//
//  DateNode.swift
//  AppStore-Today
//
//  Created by Wonseok Lee on 2021/08/17.
//

import AsyncDisplayKit

final class DateNode: ASDisplayNode {
    
    // MARK: UI
    lazy var dateLabel: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        node.attributedText = NSAttributedString(
            string: "4월 10일 토요일",
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .medium),
                .foregroundColor: UIColor.gray,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    lazy var todayTitleLabel: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        node.attributedText = NSAttributedString(
            string: "투데이",
            attributes: [
                .font: UIFont.systemFont(ofSize: 28, weight: .bold),
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
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 5.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                dateLabel,
                todayTitleLabel
            ]
        )
    }
}
