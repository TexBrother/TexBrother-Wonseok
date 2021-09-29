//
//  CardImageNode.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import AsyncDisplayKit

final class CardImageNode: ASImageNode {
    
    // MARK: Background Thread
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    // MARK: Main Thead
    
    override func layout() {
        super.layout()
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.contentMode = .scaleAspectFill
    }
}
