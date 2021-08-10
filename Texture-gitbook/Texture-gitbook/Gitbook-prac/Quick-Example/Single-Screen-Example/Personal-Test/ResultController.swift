//
//  ResultController.swift
//  Texture-gitbook
//
//  Created by Wonseok Lee on 2021/08/09.
//

import AsyncDisplayKit

final class ResultController: ASDKViewController<NaviNode> {
    // MARK: Initializing
    
    override init() {
      super.init(node: NaviNode())
      self.node.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
