//
//  CardDetailCellNode.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/10/05.
//

import AsyncDisplayKit

final class CardDetailCellNode: ASCellNode {
    
    // MARK: UI
    
    private lazy var iconNode = ASImageNode().then {
        $0.style.preferredSize = CGSize(width: 20, height: 20)
        $0.contentMode = .scaleToFill
    }
    private lazy var menuTitleNode = ASTextNode().then {
        $0.maximumNumberOfLines = 1
        $0.style.flexShrink = 1
    }
    private lazy var enterBtnNode = ASButtonNode().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .lightGray
        
    }
    
    // MARK: Background Thread
    
    init(model: CardDetailInfo) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        // MARK: Data Binding
        self.iconNode.image = UIImage(named: model.iconImgName)
        self.menuTitleNode.attributedText = NSAttributedString(string: model.menuTitle, attributes: Attr.setFont(size: 16))
    }
    
    // MARK: Main Thread
    
    override func didLoad() {
    }
    
    override func layout() {
        super.layout()
    }
}

// MARK: Extension

extension CardDetailCellNode {
    
    // MARK: Layout
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec (direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center,
                                               children: [contentLayoutSpec(), enterBtnNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), child: contentLayout)
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .center,
                                 children: [iconNode, menuTitleNode])
    }
}
