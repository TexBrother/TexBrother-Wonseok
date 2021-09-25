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
        $0.style.height = ASDimension(unit: .points, value: 186)
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
//    private lazy var validTimeNode = ASTextNode().then {
//        $0.attributedText = NSAttributedString(string: "10:00", attributes: Attr.twelveSM)
//    }
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
    private var visibleContentArray = [ASLayoutElement]()
    // var timeLeft = 600
    
    // MARK: Initializing
    
    init(model: CardInfo?) {
        super.init()
        print("LOG >>>>> init")
        self.backgroundColor = .systemBackground
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        // 등록된 카드가 있을 때
        if let data = model {
            setData(
                exist: true,
                cardImg: data.cardImgName,
                card_Name: data.name,
                card_Balance: data.balance,
                barcodeImg: data.barcodeImgName,
                barcode_Num: data.barcodeNum
            )
            // 등록된 카드가 하나도 없을 때
        } else {
            setData(
                exist: false,
                cardImg: "cardSample",
                card_Name: "스타벅스 카드를 등록해보세요.",
                card_Balance: "매장과 사이렌오더에서 쉽고 편리하게 \n 사용할 수 있고, 별도 적립할 수 있습니다.",
                barcodeImg: nil, barcode_Num: nil
            )
        }
    }
    
    // MARK: Node Life Cycle, Main Thread
    
    override func layout() {
        super.layout()
        self.dropShadow(color: .black, offSet: CGSize(width: 0, height: 5), opacity: 0.2, blur: 3)
        //        self.makeRounded(cornerRadius: <#T##CGFloat?#>)
    }
}


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
            spacing: 10,
            justifyContent: .center,
            alignItems: .center,
            children: visibleContentArray
        )
    }
    
    private func cardNameLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .horizontal, spacing: 7, justifyContent: .center, alignItems: .center, children: [cardNameNode, cardStarNode])
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
    
    private func setData(exist: Bool, cardImg: String, card_Name: String, card_Balance: String, barcodeImg: String?, barcode_Num: String?){
        cardImgNode.image = UIImage(named: cardImg)
        cardNameNode.attributedText = NSAttributedString (
            string: card_Name,
            attributes: Attr.fifteenReg
        )
        cardBalanceNode.attributedText = NSAttributedString (
            string: card_Balance,
            attributes: Attr.twentyThreeBold
        )
        
        if let barcodeImg = barcodeImg {
            barcodeImgNode.image = UIImage(named: barcodeImg)
        }
        
        if let barcode_Num = barcode_Num {
            barcodeNumNode.attributedText = NSAttributedString (
                string: barcode_Num,
                attributes: Attr.fifteenReg
            )
        }
        
        visibleContentArray = exist ?
        [cardImgNode, cardNameLayoutSpec(), cardBalanceNode, barcodeImgNode, barcodeNumNode,
         validTimeNode, chargeBtnLayoutSpec().styled{$0.alignSelf = .stretch}] : [cardImgNode, cardNameNode, cardBalanceNode]
    }
    
    // MARK: Etc
//    private func setRepeatTimer(_ interval: TimeInterval, _ rp: Bool) {
//        Timer.scheduledTimer(withTimeInterval: interval, repeats: rp) { [weak self] timer in
//            self?.timeLeft -= 1
//            if self?.timeLeft ?? 0 <= 0 {
//                timer.invalidate()
//            }
//            let hour = String(format: "%02d", Int(self?.timeLeft ?? 600/60))
//            let minute = String(format: "%02d", Int(self?.timeLeft ?? 600%60))
//            let timeToStr = "\(hour):\(minute)"
//            self?.validTimeNode.attributedText = NSAttributedString(string: timeToStr, attributes: Attr.twelveSM)
//        }
//    }
}
