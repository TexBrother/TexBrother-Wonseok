//
//  PayTab.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import AsyncDisplayKit
import CoreGraphics
import UIKit

final class PayTabController: ASDKViewController<ASScrollNode> {
    
    // MARK: UI
    
    private let rootScrollNode = ASScrollNode().then {
        $0.automaticallyManagesSubnodes = true
        $0.automaticallyManagesContentSize = true
        $0.automaticallyRelayoutOnSafeAreaChanges = true
        $0.backgroundColor = .systemBackground
        $0.scrollableDirections = [.up, .down]
    }
    
    private lazy var adBanner = ASImageNode().then {
        $0.image = UIImage(named: "bannerSample")
        $0.contentMode = .scaleToFill
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        $0.style.maxHeight = ASDimension(unit: .points, value: 80)
    }
    
    private lazy var detailBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 17, weight: .regular, scale: .large), forImageIn: .normal)
        $0.tintColor = .lightGray
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then { $0.scrollDirection = .horizontal }
    private lazy var cardCollecionNode = ASCollectionNode(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.isPagingEnabled = true
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .systemBackground
        $0.showsHorizontalScrollIndicator = false
        $0.style.maxSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
    }
    
    // MARK: Variables
    
    private lazy var menuNode = PayMenuNode()
    private var contentLayoutArray = [ASLayoutElement]()
    
    
    // MARK: Background Thread
    
    override init() {
        super.init(node: rootScrollNode)
        
        // MARK: Main Thread
        
        self.node.onDidLoad({ [weak self] _ in
            self?.setupNC()
        })

        // MARK: LayoutSpec
        
        rootScrollNode.layoutSpecBlock = ({[weak self] _, _ -> ASLayoutSpec in
            guard let self = self else { return .init() }
            
            self.contentLayoutArray = cardListData.count > 0 ?
            [self.cardCollecionNode, self.menuNode, self.adBanner] : [self.cardCollecionNode, self.adBanner]
            
            return ASStackLayoutSpec (
                direction: .vertical,
                spacing: 0.0,
                justifyContent: .start,
                alignItems: .start,
                children: self.contentLayoutArray
            )
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        self.setupNC()
    }
}

// MARK: Extension
// MARK: Protocols

extension PayTabController: ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout, UICollectionViewDelegateFlowLayout {    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return cardListData.count > 0 ? cardListData.count : 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let dataNum = cardListData.count > 0 ? cardListData.count : 1
            guard dataNum > indexPath.row else { return ASCellNode() }
            return cardListData.count > 0 ? PayCellNode(model: cardListData[indexPath.row]) : PayCellNode(model: nil)
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        if cardListData.count > 0 {
            let data = cardListData[indexPath.row]
            let dvc = CardDetailController(model: data)
            self.navigationController?.pushViewController(dvc, animated: true)
        } else {
            print("카드를 등록해주시죠")
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        var itemWidth: CGFloat = UIScreen.main.bounds.width
        itemWidth =  cardListData.count > 0 ?  itemWidth-24 : itemWidth-34
        return ASSizeRange (min: .zero, max: .init(width: itemWidth, height: .infinity))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insetForSection = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        insetForSection =  cardListData.count > 0 ? insetForSection : UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        
        return insetForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: Method

extension PayTabController {
    
    private func setupNC() {
        let barButton = UIBarButtonItem(customView: detailBtn)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.16, radius: 5)
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "Pay"
    }
}
