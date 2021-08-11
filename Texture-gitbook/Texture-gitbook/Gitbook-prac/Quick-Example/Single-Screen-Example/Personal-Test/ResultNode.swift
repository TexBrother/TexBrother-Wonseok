//
//  ResultNode.swift
//  Texture-gitbook
//
//  Created by Wonseok Lee on 2021/08/09.
//

import AsyncDisplayKit

final class ResultNode: ASDisplayNode {
    
    // MARK: UI
    private let titleNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "당신의 밤을 지켜주는",
            attributes: [
                .font: UIFont.systemFont(ofSize: 28, weight: .light),
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    private let subTitleNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "씩씩한 텍스형",
            attributes: [
                .font: UIFont.systemFont(ofSize: 28, weight: .bold),
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    private let plantImageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "texBrother")
        node.borderWidth = 1.0
        node.borderColor = UIColor.gray.cgColor
        node.cornerRadius = 15.0
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    private let descriptionNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.maximumNumberOfLines = 0
        node.attributedText = NSAttributedString(
            string: "세 달에 한 번 수염을 빗질해줘야해요\n자주 보지 못해도 루틴을 꼭 지켜주세요!",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle,
            ]
        )
        return node
    }()
    
    private let startBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .gray
        node.setTitle("시작하기", with: UIFont.systemFont(ofSize: 16, weight: .medium), with: .black, for: .normal)
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
    }
    
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 49, left: 0, bottom: 33, right: 0),
            child: contentLayoutSpec()
        )
    }
    
    
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 20.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                titleLayoutSpec(),
                imageLayoutSpec(),
                TagNode(),
                descriptionNode,
                self.startBtnNode.styled {
                    $0.width = ASDimension(unit: .points, value: super.frame.width)
                    $0.height = ASDimension(unit: .points, value: 48)
                }
            ]
        )
    }
    
    private func titleLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 5.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                self.titleNode,
                self.subTitleNode,
            ]
        )
    }
    
    private func imageLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1.0, child: self.plantImageNode).styled {
            $0.flexShrink = 1.0
        }
    }
}

