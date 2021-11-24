//
//  OtherTabController.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/11/24.
//

import AsyncDisplayKit
import SnapKit
import Then

final class OtherTabController: ASDKViewController<ASTableNode> {
    
    private let sectionTitle = ["서비스", "고객지원", "약관 및 정책"]
    private var sectionHeader = UILabel().then {
        $0.attributedText = NSAttributedString(string: "섹션",
                                               attributes: Attr.setFont(size: 18, weight: .bold))
    }
    
    // MARK: Background Thread
    
    override init() {
        super.init(node: .init(style: .grouped))
        self.node.backgroundColor = .whiteGrey
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.delegate = self
        self.node.dataSource = self
        
        // MARK: Main Thread
        
        self.node.onDidLoad({ [weak self] _ in
            self?.setStyle()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Extensions

extension OtherTabController {
    
    // MARK: Style
    
    private func setStyle() {
        self.node.view.separatorStyle = .none
        self.navigationItem.title = "Other"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.1, radius: 1)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.largeTitleTextAttributes = Attr.setFont(size: 30, weight: .semibold)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: nil)
    }
}

// MARK: Protocols

extension OtherTabController: ASTableDataSource, ASTableDelegate {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return otherMenuInfoData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UILabel().then {
            $0.attributedText = NSAttributedString(string: sectionTitle[section], attributes: Attr.setFont(size: 18, weight: .bold))
        }
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let separator = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width-20, height: 1)))
//        return separator
//    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return otherMenuInfoData[section].count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard otherMenuInfoData[indexPath.section].count > indexPath.row else { return ASCellNode() }
            return CardDetailCellNode(model: otherMenuInfoData[indexPath.section][indexPath.row])
        }
    }
}
