//
//  GiftCellNode.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/11/10.
//

import AsyncDisplayKit
import Then

final class GiftCellNode: ASCellNode {
    
    // MARK: UI
    
    private lazy var titleLabelNode = ASTextNode()
    
    private lazy var anchorIconNode = ASImageNode().then {
        $0.image = UIImage(systemName: "chevron.right")
    }
    
    private lazy var descriptionLabelNode = ASTextNode().then {
        $0.maximumNumberOfLines = 0
    }
    
    private lazy var iconImageNode = ASImageNode().then {
        let preferSize = UIScreen.main.bounds.width / 5
        $0.contentMode = .scaleAspectFit
        $0.style.preferredSize = CGSize(width: preferSize, height: preferSize)
    }
    
    // MARK: Background Thread
    
    init(model: GiftInfo?) {
        super.init()
        self.backgroundColor = .systemBackground
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.titleLabelNode.attributedText = NSAttributedString(string: model?.title ?? "error",
                                                                attributes: Attr.setFont(size: 20, weight: .bold))
        self.descriptionLabelNode.attributedText = NSAttributedString(string: model?.description ?? "error",
                                                                      attributes: Attr.setFont(size: 13))
        self.iconImageNode.image = UIImage(named: model?.iconImg ?? "plain")
    }
    
    // MARK: Main Thread
    
    override func didLoad() {
        self.layer.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.2, blur: 4)
    }
    
    override func layout() {
        super.layout()
    }
}

// MARK: Extension

extension GiftCellNode {
    
    // MARK: Layout
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20),
            child: entireContentLayoutSpec()
        )
    }
    
    private func entireContentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (direction: .horizontal,
                                  spacing: 0,
                                  justifyContent: .spaceBetween,
                                  alignItems: .center,
                                  children: [labelLayoutSpec(), iconImageNode])
    }
    
    private func labelLayoutSpec() -> ASLayoutSpec {
        let titleLabelLayout =  ASStackLayoutSpec (direction: .horizontal,
                                                   spacing: 5,
                                                   justifyContent: .start,
                                                   alignItems: .center,
                                                   children: [titleLabelNode, anchorIconNode])
        
        let entireLabelLayout = ASStackLayoutSpec (direction: .vertical,
                                                   spacing: 10,
                                                   justifyContent: .center,
                                                   alignItems: .start,
                                                   children: [titleLabelLayout, descriptionLabelNode])
        
        return entireLabelLayout
    }
}
