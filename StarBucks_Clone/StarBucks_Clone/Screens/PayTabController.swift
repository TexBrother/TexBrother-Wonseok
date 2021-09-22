//
//  PayTab.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import AsyncDisplayKit

final class PayTabController: ASDKViewController<ASScrollNode> {
    // MARK: UI
    // Not Yet
    private lazy var couponBtn = ASButtonNode()
    private lazy var eGiftBtn = ASButtonNode()
    private lazy var separateLine = ASDisplayNode()
    
    private lazy var adBanner = ASImageNode().then {
        $0.image = UIImage(named: "bannerSample")
        $0.contentMode = .scaleToFill
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
    }
    private lazy var detailBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 17, weight: .regular, scale: .large), forImageIn: .normal)
        $0.tintColor = .lightGray
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var cardCV = ASCollectionNode(collectionViewLayout: collectionViewLayout).then {
        $0.delegate = self
        $0.dataSource = self
    }
    
    private var contentLayoutArray = [ASLayoutElement]()
    
    // MARK: Initializing
    override init() {
        super.init(node: .init())
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyManagesContentSize = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.backgroundColor = .white
        self.node.layoutSpecBlock = { [weak self] (scrollNode, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        self.node.onDidLoad({ [weak self] _ in
            self?.navigationController?.navigationBar.dropShadow(color: .darkGray, offSet: CGSize(width: 0, height: 0), opacity: 0.5, radius: 5)
            self?.setupNC()
        })
        self.node.setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        
        contentLayoutArray = CardListData.count > 0 ?
            [cardCV.styled{$0.flexGrow = 1.0}, btnLayoutSpec(), adBanner] : [cardCV.styled{$0.flexGrow = 1.0}, adBanner]
        
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .start,
            children: contentLayoutArray
        )
    }
    
    private func btnLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .center,
            alignItems: .stretch,
            children: [
                couponBtn,
                separateLine,
                eGiftBtn
            ]
        )
    }
}

extension PayTabController: ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return CardListData.count > 0 ? CardListData.count : 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let dataNum = CardListData.count > 0 ? CardListData.count : 1
            guard dataNum > indexPath.row else { return ASCellNode() }
            return CardListData.count > 0 ? CardCellNode(model: CardListData[indexPath.row]) : CardCellNode(model: nil)
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        var itemWidth: CGFloat = UIScreen.main.bounds.width
        itemWidth -= 20
        return ASSizeRange (min: .zero, max: .init(width: itemWidth, height: .infinity))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 10, bottom: 5, right: 10)
    }
}

extension PayTabController {
    // MARK: - Custom Method
    private func setupNC() {
        let barButton = UIBarButtonItem(customView: detailBtn)
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "Pay"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isHidden = false
    }
}
