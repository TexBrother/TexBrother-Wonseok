//
//  CardImageNode.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import AsyncDisplayKit

final class CardImageNode: ASImageNode {
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.image = UIImage(named: "cardSample")
        self.contentMode = .scaleAspectFill
    }
    
    // MARK: Layout
    // 배너 이미지 1:1 비율
//    func contentLayoutSpec() -> ASLayoutSpec {
//        return ASRatioLayoutSpec (ratio: 1.0, child: absoluteLayoutSpec)
//    }
}
