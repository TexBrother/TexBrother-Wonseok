//
//  NaviNode.swift
//  Making-TestView
//
//  Created by Wonseok Lee on 2021/08/12.
//

import AsyncDisplayKit

final class NaviNode: ASDisplayNode {
    
    // MARK: UI
    lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.backgroundColor = .red
        node.attributedText = NSAttributedString(
            string: "식물 결과",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    lazy var backBtn: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .orange
        node.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        return node
    }()
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        // addTarget은 init()에
        backBtn.addTarget(self, action: #selector(backAction), forControlEvents: .touchUpInside)
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
        self.backgroundColor = .blue
    }
    
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let backBtnLayout =  ASCenterLayoutSpec(
            horizontalPosition: .start,
            verticalPosition: .center,
            sizingOption: [],
            child: self.backBtn
        )
        let titleLayout =  ASCenterLayoutSpec(
            horizontalPosition: .center,
            verticalPosition: .center,
            sizingOption: [],
            child: self.titleNode
        )
        
        return ASAbsoluteLayoutSpec (
            sizing: .default,
            children: [backBtnLayout, titleLayout]
        )
    }
    
    // MARK: Action
    @objc func backAction() {
        print("뒤로가기")
    }
}

