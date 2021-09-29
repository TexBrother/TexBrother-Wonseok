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
    
    private lazy var barcodeImgNode = ASImageNode().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var barcodeNumNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
    }
    
    private lazy var validTimeTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "바코드 유효시간", attributes: Attr.twelveSM)
    }
    
    private lazy var validTimerNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "10:00", attributes: Attr.twelveBoldGr)
    }
    
    // TODO: 타이머 Reset버튼
    
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
    var timer: Timer?
    var timerInfo = (600, 1.0, true)
    
    
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
            timerInfo.0 = 0
            setData(exist: false, data: cardPlainData)
        }
    }
    
    // MARK: Main Thread
    
    override func didLoad() {
        self.setRepeatTimer(timeInterval: timerInfo.1, rp: timerInfo.2)
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
    
    private func barcodeLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .center, alignItems: .center, children: [barcodeImgNode, barcodeNumNode])
    }
    
    private func timerLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .horizontal, spacing: 3, justifyContent: .center, alignItems: .center, children: [validTimeTextNode, validTimerNode])
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
            barcodeImgNode.image = UIImage(named: barcodeImg)
        }
        
        if let barcode_Num = data.barcodeNum {
            barcodeNumNode.attributedText = NSAttributedString (
                string: barcode_Num,
                attributes: Attr.fifteenReg
            )
        }
        
        visibleContentArray = exist ?
        [
            cardImgNode,
            cardInfoLayoutSpec().styled
            {
                $0.spacingBefore = 26
                $0.spacingAfter = 8
            },
            barcodeLayoutSpec(),
            timerLayoutSpec().styled
            {
                $0.spacingBefore = 8
                $0.spacingAfter = 33
            },
            chargeBtnLayoutSpec().styled{$0.alignSelf = .stretch}
        ]
        :
        [
            cardImgNode,
            cardNameNode.styled
            {
                $0.spacingBefore = 26
                $0.spacingAfter = 11
            },
            cardBalanceNode
        ]
    }
    
    // MARK: Method
    
    private func setRepeatTimer(timeInterval: TimeInterval, rp: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: rp) { [weak self] timer in
            guard let self = self else { return }
            self.timerInfo.0 -= 1
            if self.timerInfo.0 <= 0 {
                timer.invalidate()
            }
            let hour = String(format: "%02d", Int(self.timerInfo.0 / 60))
            let minute = String(format: "%02d", Int(self.timerInfo.0 - (Int(hour)!*60)))
            let timeToStr = "\(hour):\(minute)"
            self.validTimerNode.attributedText = NSAttributedString(string: timeToStr, attributes:  Attr.twelveBoldGr)
        }
    }
}
