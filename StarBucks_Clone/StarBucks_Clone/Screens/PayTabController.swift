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
    
    private lazy var cardCollecionNode = ASCollectionNode(collectionViewLayout: collectionViewLayout).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .systemBackground
        $0.style.maxSize = CGSize(width: UIScreen.main.bounds.width, height: 475)
//        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 488)
    }
    private lazy var menuNode = PayMenuNode()
    private var contentLayoutArray = [ASLayoutElement]()
    
    // MARK: Initializing
    override init() {
        super.init(node: .init())
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyManagesContentSize = true
        self.node.backgroundColor = .blue
        self.node.onDidLoad({ [weak self] _ in
            self?.setupNC()
        })
        self.node.layoutSpecBlock = ({[weak self] (scrollNode, constrainedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constrainedSize) ?? ASLayoutSpec()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        contentLayoutArray = CardListData.count > 0 ?
        [cardCollecionNode, menuNode, adBanner] : [cardCollecionNode.styled{$0.flexShrink = 1.0}, adBanner.styled{$0.flexShrink = 1.0}]

        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .center,
            children: contentLayoutArray
        )
    }
}

extension PayTabController: ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout, UICollectionViewDelegateFlowLayout {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return CardListData.count > 0 ? CardListData.count : 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let dataNum = CardListData.count > 0 ? CardListData.count : 1
            guard dataNum > indexPath.row else { return ASCellNode() }
            return CardListData.count > 0 ? PayCellNode(model: CardListData[indexPath.row]) : PayCellNode(model: nil)
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        var itemWidth: CGFloat = UIScreen.main.bounds.width
        itemWidth =  CardListData.count > 0 ? itemWidth-34 : itemWidth-24
        return ASSizeRange (min: .zero, max: .init(width: itemWidth, height: .infinity))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insetForSection = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        insetForSection =  CardListData.count > 0 ?
        UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17) : insetForSection
        
        return insetForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension PayTabController {
    
    // MARK: - Custom Method
    private func setupNC() {
        let barButton = UIBarButtonItem(customView: detailBtn)
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "Pay"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .white
        //        navigationController?.navigationBar.shadowImage = UIImage()
        
        let normalNaviBarAppearance = UINavigationBarAppearance().then {
            $0.shadowImage = UIImage()
            $0.backgroundColor = .systemBackground
            $0.shadowColor = nil
        }
        navigationController?.navigationBar.standardAppearance = normalNaviBarAppearance
        navigationController?.navigationBar.dropShadow(color: .darkGray, offSet: CGSize(width: 0, height: 0), opacity: 0.5, radius: 5)
        
        let naviBarAppearance = UINavigationBarAppearance().then {
            $0.shadowImage = UIImage()
            $0.backgroundColor = .systemBackground
            $0.shadowColor = nil
        }
        navigationController?.navigationBar.scrollEdgeAppearance = naviBarAppearance
    }
}
