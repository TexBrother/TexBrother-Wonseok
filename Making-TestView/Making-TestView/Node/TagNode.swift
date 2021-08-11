//
//  TagNode.swift
//  Making-TestView
//
//  Created by Wonseok Lee on 2021/08/12.
//

import AsyncDisplayKit

final class TagNode: ASDisplayNode {
    
    lazy var flowerName: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "꽃말",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: UIColor.stukiColor,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    lazy var flowerMean: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "사랑과 열정",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: UIColor.stukiColor,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    lazy var separatorNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = UIColor.stukiColor
        node.styled {
            $0.width = ASDimension(unit: .points, value: 1)
            $0.height = ASDimension(unit: .points, value: 10)
        }
        return node
    }()
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
        self.borderWidth = 1.0
        self.borderColor = UIColor.stukiColor.cgColor
        self.cornerRadius = self.frame.height / 2
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15),
            child: contentLayoutSpec()
        )
    }
    
    private func flowerNameLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 5.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                self.flowerName.styled {
                    $0.flexGrow = 1.0
                    $0.flexShrink = 0.5
                },
                self.separatorNode.styled {
                    $0.flexShrink = 1.0
                }
            ]
        )
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 10.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                flowerNameLayoutSpec(),
                self.flowerMean
            ]
        )
    }
}
