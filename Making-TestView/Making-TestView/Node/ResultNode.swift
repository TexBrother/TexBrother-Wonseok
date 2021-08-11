//
//  ResultNode.swift
//  Making-TestView
//
//  Created by Wonseok Lee on 2021/08/12.
//

import AsyncDisplayKit

final class ResultNode: ASDisplayNode {
    
    // MARK: UI
    lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "당신의 밤을 지켜주는",
            attributes: [
                .font: UIFont.systemFont(ofSize: 28, weight: .light),
                .foregroundColor: UIColor.nblack,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    lazy var subTitleNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "씩씩한 단모환",
            attributes: [
                .font: UIFont.systemFont(ofSize: 28, weight: .bold),
                .foregroundColor: UIColor.nblack,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    lazy var plantImageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "imgFinalSun")
        node.cornerRadius = 15.0
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    lazy var descriptionNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.maximumNumberOfLines = 0
        node.attributedText = NSAttributedString(
            string: "세 달에 한 번 물을 주는 것을 추천해요\n자주 보지 못해도 분명 당신의 연락을 기다릴거에요!",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.nblack,
                .paragraphStyle: paragraphStyle,
            ]
        )
        return node
    }()
    
    lazy var startBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .stukiColor
        node.setTitle("시작하기", with: UIFont.systemFont(ofSize: 16, weight: .medium), with: .white, for: .normal)
        node.style.height = ASDimension(unit: .points, value: 48)
        node.cornerRadius = 24
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
            insets: UIEdgeInsets(top: 49, left: 15, bottom: 33, right: 15),
            child: finalContentLayoutSpec()
        )
    }
    
    private func finalContentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 38.0,
            justifyContent: .center,
            alignItems: .notSet,
            children: [
                withoutBtnContentLayoutSpec(),
                startBtnNode.styled {
                    $0.flexGrow = 1
                    $0.alignSelf = .stretch
                }
            ]
        )
    }
    
    private func withoutBtnContentLayoutSpec() -> ASLayoutSpec {
        let withoutContent = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 20.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                resultTitleLayoutSpec(),
                imageLayoutSpec(),
                TagNode(),
                descriptionNode,
            ]
        )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30),
            child: withoutContent
        )
    }
    
    private func resultTitleLayoutSpec() -> ASLayoutSpec {
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


