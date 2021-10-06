//
//  CardDetailController.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/10/05.
//

import AsyncDisplayKit
import Then

final class CardDetailController: ASDKViewController<ASDisplayNode> {
    
    // MARK: UI
    
    private lazy var cardNameNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
        $0.attributedText = NSAttributedString(string: "카드이름", attributes: Attr.twentyEightBold)
    }
    
    private lazy var cardEditBtn = ASButtonNode().then {
        $0.setImage(UIImage(named: "pencil"), for: .normal)
    }
    
    private lazy var cardBalanceNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
        $0.attributedText = NSAttributedString(string: "카드 잔액", attributes: Attr.fifteenReg)
    }
    
    private lazy var cardBalanceNumNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
        $0.attributedText = NSAttributedString(string: "300원", attributes: Attr.twentyThreeBold)
    }
    
    private lazy var cardImageNode = CardImageNode().then {
        let width = UIScreen.main.bounds.width/3
        $0.contentMode = .scaleToFill
        $0.style.preferredSize = CGSize(width: width, height: width * 0.6)
    }
    
    private lazy var cardBardcodeNode = CardBarcodeNode()
    
    private lazy var menuTableNode = ASTableNode(style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .whiteGrey
    }
    
    // MARK: Background Thread
    
    init(model: CardInfo) {
        super.init(node: .init())
        self.node.backgroundColor = .systemBackground
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.setData(data: model)
        
        // MARK: LayoutSpec
        
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        
        // MARK: Main Thread
        
        self.node.onDidLoad({ [weak self] _ in
            guard let self = self else { return }
            self.cardBardcodeNode.setRepeatTimer(totalTime: 600, timeInterval: 1.0, rp: true)
            self.tabBarController?.tabBar.isHidden = true
            self.tabBarController?.tabBar.isTranslucent = true
            self.navigationController?.navigationBar.tintColor = .seaweedGreen
            self.navigationItem.largeTitleDisplayMode = .never
            self.menuTableNode.view.separatorStyle = .none
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: Extension

extension CardDetailController {
    
    // MARK: Layout
    
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch,
                                 children: [headerLayoutSpec(), menuTableNode.styled { $0.flexGrow = 1.0 }])
    }
    
    private func headerLayoutSpec() -> ASLayoutSpec {
        let cardNameArea = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center,
                                             children: [cardNameNode, cardEditBtn])
        
        let cardTextInfo = ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .start, alignItems: .start,
                                             children: [cardBalanceNode, cardBalanceNumNode])
        
        let cardInfo = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .start,
                                         children: [cardImageNode,cardTextInfo])
        
        let headerContentLayout = ASStackLayoutSpec ( direction: .vertical, spacing: 30, justifyContent: .start, alignItems: .stretch,
                                                      children: [
                                                        cardNameArea,
                                                        cardInfo.styled { $0.spacingBefore = 10 },
                                                        cardBardcodeNode.styled { $0.alignSelf = .center }])
        
        var inset = self.node.safeAreaInsets
        inset.left += 20
        inset.right += 20
        return ASInsetLayoutSpec(insets: inset, child: headerContentLayout)
    }
    
    // MARK: Data Binding
    
    private func setData(data: CardInfo){
        cardImageNode.image = UIImage(named: data.cardImgName)
        
        cardNameNode.attributedText = NSAttributedString (
            string: data.name,
            attributes: Attr.twentyEightBold
        )
        
        cardBalanceNumNode.attributedText = NSAttributedString (
            string: data.balance,
            attributes: Attr.twentyThreeBold
        )
        
        if let barcodeImg = data.barcodeImgName {
            cardBardcodeNode.barcodeImgNode.image = UIImage(named: barcodeImg)
        }
        
        if let barcode_Num = data.barcodeNum {
            cardBardcodeNode.barcodeNumNode.attributedText = NSAttributedString (
                string: barcode_Num,
                attributes: Attr.fifteenReg
            )
        }
    }
}

extension CardDetailController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return cardDetailMenuData.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard cardDetailMenuData.count > indexPath.row else { return ASCellNode() }
            return CardDetailCellNode(model: cardDetailMenuData[indexPath.row])
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 150))
    }
}
