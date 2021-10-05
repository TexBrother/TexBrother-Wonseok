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
    
    private lazy var cardStarNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "star"), for: .normal)
    }
    
    private lazy var cardBalanceNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 0
    }
    
    private lazy var barcodeAreaNode = CardBarcodeNode()
    
    private lazy var autoChargeBtnNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "autoCharge"), for: .normal)
    }
    
    private lazy var autoChargeTextNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.attributedText = NSAttributedString(string: "자동충전", attributes: Attr.twelveSM)
    }
    
    private lazy var normalChargeBtnNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "normalCharge"), for: .normal)
    }
    
    private lazy var normalChargeTextNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.attributedText = NSAttributedString(string: "일반충전", attributes: Attr.twelveSM)
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
        let cardNameStack = ASStackLayoutSpec(direction: .horizontal, spacing: 7, justifyContent: .center, alignItems: .center, children: [cardNameNode, cardStarNode])
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
            attributes: exist ? Attr.thirteenSM : Attr.seventeenSM
        )
        cardBalanceNode.attributedText = NSAttributedString (
            string: data.balance,
            attributes: exist ? Attr.twentyThreeBold : Attr.fourteenMedGr
        )
        
        if let barcodeImg = data.barcodeImgName {
            barcodeAreaNode.barcodeImgNode.image = UIImage(named: barcodeImg)
        }
        
        if let barcode_Num = data.barcodeNum {
            barcodeAreaNode.barcodeNumNode.attributedText = NSAttributedString (
                string: barcode_Num,
                attributes: Attr.fifteenReg
            )
        }
        
        visibleContentArray = exist ?
        [
            cardImgNode,
            cardInfoLayoutSpec().styled {
                $0.spacingBefore = 26
                $0.spacingAfter = 8
            },
            barcodeAreaNode.styled {
                $0.spacingAfter = 33
            },
            chargeBtnLayoutSpec().styled{$0.alignSelf = .stretch}
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
