//
//  TodayVC.swift
//  AppStore-Today
//
//  Created by Wonseok Lee on 2021/08/17.
//

import AsyncDisplayKit

final class TodayVC: ASDKViewController<ASDisplayNode> {
        
    // MARK: Initializing
    override init() {
        super.init(node: ASDisplayNode())
        self.node.backgroundColor = .black
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        var contentInset: UIEdgeInsets = self.node.safeAreaInsets
        contentInset.left += 20.0
        contentInset.right += 20.0
        contentInset.top += 20.0
        
        return ASInsetLayoutSpec (
            insets: contentInset,
            child: contentLayoutSpec()
        )
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 5.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                headerLayoutSpec(),
                BannerNode()
            ]
        )
    }
    
    private func headerLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .spaceBetween,
            alignItems: .baselineLast,
            children: [
                DateNode(),
                ProfileAreaNode()
            ]
        )
    }
}
