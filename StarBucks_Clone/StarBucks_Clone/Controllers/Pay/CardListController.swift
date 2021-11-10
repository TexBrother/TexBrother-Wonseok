//
//  CardListController.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/10/13.
//
// TODO: separtor 우측 inset만 안먹히는거 해결하기
import AsyncDisplayKit

final class CardListController: ASDKViewController<ASTableNode> {
    
    private lazy var adBannerNode = UIImageView().then {
        $0.image = UIImage(named: "bannerSample")
    }
    
    // MARK: Background Thread
    
    override init() {
        super.init(node: .init(style: .grouped))
        self.node.backgroundColor = .systemBackground
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
extension CardListController {
    
    // MARK: Style
    
    private func setStyle() {
        self.node.view.separatorStyle = .singleLine
        self.node.view.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.node.view.separatorInsetReference = .fromCellEdges
        self.navigationItem.title = "카드(\(cardListData.count))"
        self.navigationController?.navigationBar.largeTitleTextAttributes = Attr.setFont(size: 30, weight: .semibold)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
}

// MARK: Protocols
extension CardListController: ASTableDataSource, ASTableDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return adBannerNode
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 85
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return cardListData.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard cardListData.count > indexPath.row else { return ASCellNode() }
            return CardListCellNode(model: cardListData[indexPath.row], isFirstCard: indexPath.row == 0 ? true : false)
        }
    }
}
