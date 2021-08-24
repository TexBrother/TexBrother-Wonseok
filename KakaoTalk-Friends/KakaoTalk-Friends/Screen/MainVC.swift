//
//  MainVC.swift
//  KakaoTalk-Friends
//
//  Created by Wonseok Lee on 2021/08/24.
// https://github.com/GeekTree0101/DoggyGram 보고 많이 참고함

import AsyncDisplayKit

final class MainVC: ASDKViewController<ASDisplayNode> {
    // MARK: TableNode Section Enum
    enum Section: Int, CaseIterable {
        case myProfile
        case freinds
    }
    
    // MARK: UI
    lazy var tableNode: ASTableNode = {
        let node = ASTableNode(style: .plain)
        node.delegate = self
        node.dataSource = self
        node.backgroundColor = .white
        return node
    }()
    
    lazy var headerNode = HeaderNode()
    
    // MARK: Initializing
    override init() {
        super.init(node: .init())
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        
        // ASTableView에 접근하기
        self.node.onDidLoad({ [weak self] _ in
            self?.tableNode.view.separatorStyle = .none
            self?.tableNode.view.showsVerticalScrollIndicator = false
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                headerNode,
                tableNode.styled({
                    $0.flexGrow = 1.0
                })
            ]
        )
        let safeAreaInset: UIEdgeInsets = self.view.safeAreaInsets
        return ASInsetLayoutSpec (
            insets: safeAreaInset, child: contentLayout)
    }
}

// MARK: Protocols
extension MainVC: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        print("클릭 \(indexPath.row)")
    }
}
extension MainVC: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return Section.allCases.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section.init(rawValue: section) else { return 0 }
        
        switch section {
        case .myProfile: return 1
        case .freinds: return FreindsListData.count
        }
    }
    
    // nodeForRowAt보다 nodeBlockForRowAt 사용 권장
    // tableNode 가 모든 Cell 을 동시에 준비하고 보여줄 수 있도록, nodeBlockForRowAt 을 사용하는 것이 좋습니다
    // nodeBlock 은 모든 SubNode 의 생성자를 백그라운드에서 실행할 수 있게합니다.
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard let section = Section.init(rawValue: indexPath.section) else { return ASCellNode() }
            
            switch section {
            case .myProfile:
                guard FreindsListData.count > indexPath.row else { return ASCellNode() }
                let myInfo = FreindsList(imageName: "friendtabProfileImg", userName: "텍스형", statusMessage: "내가 텍스형이다!")
                return ProfileCellNode(model: myInfo, category: section)
            case .freinds:
                guard FreindsListData.count > indexPath.row else { return ASCellNode() }
                let freindModel = FreindsListData[indexPath.row]
                return ProfileCellNode(model: freindModel, category: section)
            }
        }
    }
    
    // cell 사이즈 리미트 제한
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        guard let section = Section.init(rawValue: indexPath.section) else { return ASSizeRange() }
        switch section {
        case .myProfile:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 100))
        case .freinds:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 50))
        }
    }
    
    //tableView의 레이어 변경
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}
