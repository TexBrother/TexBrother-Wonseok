//
//  CardDetailController.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/10/05.
//
import AsyncDisplayKit
import Then

final class CardDetailController: BaseViewController {
    
    // MARK: UI
    
    private lazy var cardNameNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
        $0.attributedText = NSAttributedString(string: "카드이름",
                                               attributes: Attr.setFont(size: 28, weight: .bold))
    }
    
    private lazy var cardEditBtn = ASButtonNode().then {
        $0.setImage(Const.PayTab.pencil, for: .normal)
    }
    
    private lazy var cardBalanceNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
        $0.attributedText = NSAttributedString(string: "카드 잔액",
                                               attributes: Attr.setFont(size: 15))
    }
    
    private lazy var cardBalanceNumNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
        $0.attributedText = NSAttributedString(string: "300원",
                                               attributes: Attr.setFont(size: 23, weight: .bold))
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
        super.init()
        self.setData(data: model)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch,
                                 children: [headerLayoutSpec(), menuTableNode.styled { $0.flexGrow = 1.0 }])
    }
    
    // MARK: Main Thread
    
    override func didLoad() {
        self.setStyle()
    }
}


// MARK: Extension
extension CardDetailController {
    
    // MARK: Layout
    
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
    
    // MARK: Etc
    
    private func setStyle() {
        self.cardBardcodeNode.setRepeatTimer(totalTime: 600, timeInterval: 1.0, rp: true)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.navigationItem.largeTitleDisplayMode = .never
        self.menuTableNode.view.separatorStyle = .none
    }
    
    private func setData(data: CardInfo){
        cardImageNode.image = UIImage(named: data.cardImgName)
        
        cardNameNode.attributedText = NSAttributedString (
            string: data.name,
            attributes: Attr.setFont(size: 28, weight: .bold)
        )
        
        cardBalanceNumNode.attributedText = NSAttributedString (
            string: data.balance,
            attributes: Attr.setFont(size: 23, weight: .bold)
        )
        
        if let barcodeImg = data.barcodeImgName {
            cardBardcodeNode.barcodeImgNode.image = UIImage(named: barcodeImg)
        }
        
        if let barcode_Num = data.barcodeNum {
            cardBardcodeNode.barcodeNumNode.attributedText = NSAttributedString (
                string: barcode_Num,
                attributes: Attr.setFont(size: 15)
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
