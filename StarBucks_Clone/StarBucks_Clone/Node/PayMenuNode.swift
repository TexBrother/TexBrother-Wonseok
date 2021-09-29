//
//  PayMenuNode.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/25.
//

import AsyncDisplayKit

final class PayMenuNode: ASDisplayNode {
    
    // MARK: UI
    
    private lazy var couponBtn = ASButtonNode().then {
        $0.setTitle("Coupon", with: UIFont.systemFont(ofSize: 15, weight: .bold), with: .black, for: .normal)
        $0.backgroundColor = .systemBackground
    }
    
    private lazy var eGiftBtn = ASButtonNode().then {
        $0.setTitle("e-Gift Item", with: UIFont.systemFont(ofSize: 15, weight: .bold), with: .black, for: .normal)
        $0.backgroundColor = .systemBackground
    }
    
    private lazy var separator = ASDisplayNode().then {
        $0.backgroundColor = .systemGray2
        $0.style.preferredSize = CGSize(width: 1, height: 10)
    }
    
    // MARK: Background Thread
    
    override init() {
        super.init()
        self.backgroundColor = .systemBackground
        self.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 70)
        automaticallyManagesSubnodes = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LayoutSpecs
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceAround,
            alignItems: .center,
            children: [
                couponBtn.styled {
                    $0.alignSelf = .stretch
                    $0.flexGrow = 0.5
                },
                separator,
                eGiftBtn.styled {
                    $0.alignSelf = .stretch
                    $0.flexGrow = 0.5
                }
            ]
        )
    }
}
