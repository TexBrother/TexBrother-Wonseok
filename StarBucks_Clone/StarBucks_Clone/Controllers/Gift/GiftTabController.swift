//
//  GiftTabController.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/11/10.
//

import AsyncDisplayKit

final class GiftTabController: ASDKViewController<ASCollectionNode> {
    
    // MARK: Background Thread
    
    override init() {
        super.init(node: ASCollectionNode.init(collectionViewLayout: UICollectionViewFlowLayout().then { $0.scrollDirection = .vertical }))
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

extension GiftTabController {
    
    // MARK: Style
    
    private func setStyle() {
        self.navigationItem.title = "Gift"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.largeTitleTextAttributes = Attr.setFont(size: 30, weight: .semibold)
    }
}

// MARK: Protocols

extension GiftTabController: ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout, UICollectionViewDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return giftInfoList.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard giftInfoList.count > indexPath.row else { return ASCellNode() }
            return GiftCellNode(model: giftInfoList[indexPath.row])
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let itemWidth: CGFloat = UIScreen.main.bounds.width - 20
        return ASSizeRange (min: .init(width: itemWidth, height: 150),
                            max: .init(width: itemWidth, height: 150))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}
