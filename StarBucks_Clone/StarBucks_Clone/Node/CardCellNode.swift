//
//  CardCellNode.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import AsyncDisplayKit
import Then

final class CardCellNode: ASCellNode {
    // MARK: UI
    private lazy var cardImage = CardImageNode().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    private lazy var cardName = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
    }
    private lazy var cardBalance = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 0
    }
    private lazy var barcodeImage = ASImageNode().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    private lazy var barcodeNum = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
    }
    private lazy var autoChargeBtn = ASButtonNode().then {
        $0.setImage(UIImage(named: "profileCloseBtn"), for: .normal)
    }
    private lazy var normalChargeBtn = ASButtonNode().then {
        $0.setImage(UIImage(named: "profileCloseBtn"), for: .normal)
    }
    
    private var contentLayoutArray = [ASLayoutElement]()
    
    // MARK: Initializing
    init(model: CardInfo?) {
        super.init()
        print("LOG >>>>> init")
        self.backgroundColor = .systemBackground
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        if let data = model {
            print("exist")
            // profileImage
            cardImage.image = UIImage(named: data.cardImgName)
            barcodeImage.image = UIImage(named: data.barcodeImgName)
            cardName.attributedText = NSAttributedString (
                string: data.name,
                attributes: Attr.nameAttribute
            )
            cardBalance.attributedText = NSAttributedString (
                string: data.balance,
                attributes: Attr.balanceAttribute
            )
            barcodeNum.attributedText = NSAttributedString (
                string: data.barcodeNum,
                attributes: Attr.etcAttribute
            )
            contentLayoutArray = [
                cardImage,
                cardName,
                cardBalance,
                barcodeImage,
                barcodeNum,
                chargeBtnLayoutSpec()
            ]
        } else {
            print("not exist")
            // 등록된 카드가 하나도 없을 때
            cardImage.image = UIImage(named: "cardSample")
            cardName.attributedText = NSAttributedString (
                string: "스타벅스 카드를 등록해보세요.",
                attributes: Attr.nameAttribute
            )
            cardBalance.attributedText = NSAttributedString (
                string: "매장과 사이렌오더에서 쉽고 편리하게 \n 사용할 수 있고, 별도 적립할 수 있습니다.",
                attributes: Attr.balanceAttribute
            )
            
            contentLayoutArray = [
                cardImage,
                cardName,
                cardBalance,
            ]
        }
    }
    
    // MARK: Node Life Cycle, Main Thread
    override func layout() {
        super.layout()
        self.dropShadow(color: .black, offSet: CGSize(width: 0, height: 5), opacity: 0.2, blur: 3)
//        self.makeRounded(cornerRadius: <#T##CGFloat?#>)
    }
    
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 19, left: 20, bottom: 0, right: 20),
            child: contentLayoutSpec()
        )
    }
}

extension CardCellNode {
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 10,
            justifyContent: .center,
            alignItems: .center,
            children: contentLayoutArray
        )
    }
    
    private func chargeBtnLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 0,
            justifyContent: .center,
            alignItems: .start,
            children: [
                autoChargeBtn,
                normalChargeBtn
            ]
        )
    }
}
