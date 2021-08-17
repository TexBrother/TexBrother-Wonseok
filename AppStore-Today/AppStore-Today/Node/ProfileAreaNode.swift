//
//  ProfileAreaNode.swift
//  AppStore-Today
//
//  Created by Wonseok Lee on 2021/08/17.
//

import AsyncDisplayKit

final class ProfileAreaNode: ASDisplayNode {
    
    // MARK: UI
    lazy var profileImgNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFill
        node.image = UIImage(named: "texbrother")
        return node
    }()
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.style.width = ASDimension(unit: .points, value: 30)
        self.layoutSpecBlock = { (_ , _) -> ASLayoutSpec in
            return ASRatioLayoutSpec(ratio: 1.0, child: self.profileImgNode).styled {
                $0.flexShrink = 1.0
            }
        }
    }
        
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
        profileImgNode.cornerRadius = self.frame.height / 2
    }
}
