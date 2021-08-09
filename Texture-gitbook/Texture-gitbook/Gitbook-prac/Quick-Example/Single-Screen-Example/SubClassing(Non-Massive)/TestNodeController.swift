//
//  TestNodeController.swift
//  Texture-gitbook
//
//  Created by Wonseok Lee on 2021/08/09.
//

import AsyncDisplayKit

final class TestNodeController: ASDKViewController<TestNode> {

  // MARK: Initializing
  
  override init() {
    super.init(node: TestNode())
    self.node.backgroundColor = .white
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
