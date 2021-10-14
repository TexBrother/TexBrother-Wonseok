//
//  CardListCellNode.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/10/13.
//

// TODO: representativeBtn 클릭시 가장 상단에 고정되는 로직 구현

import AsyncDisplayKit

final class CardListCellNode: ASCellNode {
    private lazy var cardImgNode = CardImageNode()
    private lazy var cardNameNode = ASTextNode()
    private lazy var cardBalanceNode = ASTextNode()
//    private lazy var separatorLine = ASDisplayNode()
    private lazy var cardStarBtnNode = ASButtonNode().then {
        $0.imageNode.style.preferredSize = CGSize(width: 30, height: 30)
        $0.setImage(UIImage(named: "star"), for: .normal)
    }
    
    // MARK: Background Thread
    
    init(model: CardInfo, isFirstCard: Bool) {
        super.init()
        print("LOG >>>>> init CardListCellNode")
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.dataBinding(data: model, isFirst: isFirstCard)
        self.setStyle(isFirst: isFirstCard)
    }
    
    // MARK: Main Thread
    
    override func layout() {
        super.layout()
//        self.separatorLine.style.preferredSize = CGSize(width: UIScreen.main.bounds.width-40, height: 1)
    }
}

// MARK: Extension

extension CardListCellNode {
    
    // MARK: Layout
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20),
                                 child: contentLayoutSpec())
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let textsLayoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 3, justifyContent: .center, alignItems: .start,
                                                children: [ cardNameNode.styled { $0.spacingBefore = 5 },
                                                            cardBalanceNode
                                                          ])
        
        let withoutBtnLayoutSpec = ASStackLayoutSpec(direction: .horizontal, spacing: 15, justifyContent: .start, alignItems: .start,
                                                     children: [ cardImgNode,
                                                                 textsLayoutSpec
                                                               ])
        
        return ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center,
                                 children: [ withoutBtnLayoutSpec,
                                             cardStarBtnNode
                                           ])
    }
    
    // MARK: Etc
    
    private func setStyle(isFirst: Bool) {
        let cardWidth: Double
        cardWidth = isFirst ? 130 : 65
        self.cardImgNode.style.preferredSize = CGSize(width: cardWidth, height: cardWidth*0.6)
        self.backgroundColor = .systemBackground
    }
    
    private func dataBinding(data: CardInfo, isFirst: Bool) {
        cardImgNode.image = UIImage(named: data.cardImgName)
        cardNameNode.attributedText = NSAttributedString (
            string: data.name,
            attributes: isFirst ?
            Attr.setFont(size: 13) : Attr.setFont(size: 11, color: .darkGray)
        )
        cardBalanceNode.attributedText = NSAttributedString (
            string: data.balance,
            attributes: Attr.setFont(size: isFirst ? 20 : 15, weight: .bold)
        )
        if let represantiveStar = data.isStar {
            cardStarBtnNode.setImage(UIImage(named: represantiveStar ? "star" : "unStar"), for: .normal)
        }
    }
}

