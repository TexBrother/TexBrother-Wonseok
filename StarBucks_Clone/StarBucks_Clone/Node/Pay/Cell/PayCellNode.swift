//
//  PayCellNode.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import AsyncDisplayKit
import Then

final class PayCellNode: ASCellNode {
    
    // MARK: UI
    
    private lazy var cardImgNode = CardImageNode().then {
        $0.clipsToBounds = true
        $0.style.height = ASDimension(unit: .points, value: 189)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var cardNameNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
    }
    
    private lazy var cardStarBtnNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "unStar"), for: .normal)
    }
    
    private lazy var cardBalanceNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 0
    }
    
    private lazy var barcodeAreaNode = CardBarcodeNode()
    
    private lazy var autoChargeBtnNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "autoCharge"), for: .normal)
        $0.style.preferredSize = CGSize(width: 24, height: 25)
        $0.contentMode = .scaleToFill
    }
    
    private lazy var autoChargeTextNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.attributedText = NSAttributedString(string: "자동충전",
                                               attributes: Attr.setFont(size: 12, weight: .semibold))
    }
    
    private lazy var normalChargeBtnNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "normalCharge"), for: .normal)
        $0.style.preferredSize = CGSize(width: 24, height: 25)
        $0.contentMode = .scaleToFill
    }
    
    private lazy var normalChargeTextNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.attributedText = NSAttributedString(string: "일반충전",
                                               attributes: Attr.setFont(size: 12, weight: .semibold))
    }
    
    // MARK: Variables
    
    private var visibleContentArray = [ASLayoutElement]()
    var timeLeft = 600
    
    
    // MARK: Background Thread
    
    init(model: CardInfo?) {
        super.init()
        print("LOG >>>>> init")
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        self.backgroundColor = .systemBackground
        self.style.minHeight = ASDimension(unit: .points, value: 445)
        self.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.16, blur: 6)
        
        // 등록된 카드가 있을 때
        if let data = model {
            setData(exist: true, data: data)
            // 등록된 카드가 하나도 없을 때
        } else {
            timeLeft = 0
            setData(exist: false, data: cardPlainData)
        }
    }
    
    // MARK: Main Thread
    
    override func didLoad() {
        self.barcodeAreaNode.setRepeatTimer(totalTime: timeLeft, timeInterval: 1.0, rp: true)
    }
    
    override func layout() {
        super.layout()
    }
}

// MARK: Extension

extension PayCellNode {
    
    // MARK: Layout
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 19, left: 20, bottom: 20, right: 20),
            child: contentLayoutSpec()
        )
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0,
            justifyContent: .start,
            alignItems: .center,
            children: visibleContentArray
        )
    }
    
    private func cardInfoLayoutSpec() -> ASLayoutSpec {
        let cardNameStack = ASStackLayoutSpec(direction: .horizontal, spacing: 7, justifyContent: .center, alignItems: .center, children: [cardNameNode, cardStarBtnNode])
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .center, children: [cardNameStack, cardBalanceNode])
    }
    
    private func chargeBtnLayoutSpec() -> ASLayoutSpec {
        let makeAutoChargeBtn = ASStackLayoutSpec (direction: .vertical, spacing: 11, justifyContent: .center, alignItems: .center, children: [
            autoChargeBtnNode,
            autoChargeTextNode
        ])
        
        let makeNormalChargeBtn = ASStackLayoutSpec (direction: .vertical, spacing: 10, justifyContent: .center, alignItems: .center, children: [
            normalChargeBtnNode,
            normalChargeTextNode
        ])
        
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceAround,
            alignItems: .center,
            children: [
                makeAutoChargeBtn,
                makeNormalChargeBtn
            ]
        )
    }
    
    // MARK: Data Binding
    
    private func setData(exist: Bool, data: CardInfo){
        cardImgNode.image = UIImage(named: data.cardImgName)
        cardNameNode.attributedText = NSAttributedString (
            string: data.name,
            attributes: Attr.setFont(size: exist ? 13 : 17, weight: .semibold)
        )
        cardBalanceNode.attributedText = NSAttributedString (
            string: data.balance,
            attributes: exist ?
            Attr.setFont(size: 23, weight: .bold) : Attr.setFont(size: 14, weight: .medium, color: .gray)
        )
        
        if let barcodeImg = data.barcodeImgName {
            barcodeAreaNode.barcodeImgNode.image = UIImage(named: barcodeImg)
        }
        
        if let barcode_Num = data.barcodeNum {
            barcodeAreaNode.barcodeNumNode.attributedText = NSAttributedString (
                string: barcode_Num,
                attributes: Attr.setFont(size: 15)
            )
        }
        
        if let represantiveStar = data.isStar {
            cardStarBtnNode.imageNode.image = UIImage(named: represantiveStar ? "star" : "unStar")
        }
        
        visibleContentArray = exist ?
        [
            cardImgNode,
            cardInfoLayoutSpec().styled {
                $0.spacingBefore = 26
                $0.spacingAfter = 10
            },
            barcodeAreaNode.styled { $0.spacingAfter = 20 },
            chargeBtnLayoutSpec().styled{ $0.alignSelf = .stretch }
        ]
        :
        [
            cardImgNode,
            cardNameNode.styled {
                $0.spacingBefore = 26
                $0.spacingAfter = 11
            },
            cardBalanceNode
        ]
    }
}
