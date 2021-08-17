//
//  BannerNode.swift
//  AppStore-Today
//
//  Created by Wonseok Lee on 2021/08/17.
//

import AsyncDisplayKit

final class BannerNode: ASImageNode {
    
    // MARK: UI
    lazy var subTitleNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        node.attributedText = NSAttributedString(
            string: "고르고 골랐어요",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .bold),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    lazy var mainTitleNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        node.attributedText = NSAttributedString(
            string: "이번 주 추천 앱",
            attributes: [
                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    lazy var descriptionNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        node.attributedText = NSAttributedString(
            string: "새로 나온 앱과 업데이트를 모아봤습니다.",
            attributes: [
                .font: UIFont.systemFont(ofSize: 11, weight: .medium),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.layoutSpecBlock = { (_ , _) -> ASLayoutSpec in
            return self.contentLayoutSpec()
            
        }
        self.style.width = ASDimension(unit: .points, value: 335.0)
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
        self.backgroundColor = .clear
        self.image = UIImage(named: "appstoreBanner1")
        self.contentMode = .scaleAspectFill
    }
    
    // MARK: Layout
    func contentLayoutSpec() -> ASLayoutSpec {
        let absoluteLayoutSpec = ASAbsoluteLayoutSpec (sizing: .default, children: [self.titleLayoutSpec(), self.descriptionLayoutSpec()])
        
        return ASRatioLayoutSpec (ratio: 1.0, child: absoluteLayoutSpec)
    }
    
    func titleLayoutSpec() -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 16.0, left: 20.0, bottom: 0.0, right: 0.0)
        let titleInsetLayout = ASInsetLayoutSpec(insets: insets, child: titleStackLayoutSpec())
        
        return ASRelativeLayoutSpec (
            horizontalPosition: .start,
            verticalPosition: .start,
            sizingOption: [],
            child: titleInsetLayout
        )
    }
    
    func titleStackLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 5.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                subTitleNode,
                mainTitleNode
            ]
        )
    }
    
    func descriptionLayoutSpec() -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 15.0, right: 0.0)
        let descriptionInsetLayout = ASInsetLayoutSpec(insets: insets, child: descriptionNode)
        
        return ASRelativeLayoutSpec (
            horizontalPosition: .start,
            verticalPosition: .end,
            sizingOption: [],
            child: descriptionInsetLayout
        )
    }
}
