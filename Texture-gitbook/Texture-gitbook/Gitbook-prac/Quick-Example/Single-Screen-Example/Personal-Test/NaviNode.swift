//
//  NaviNode.swift
//  Texture-gitbook
//
//  Created by Wonseok Lee on 2021/08/10.
//

import AsyncDisplayKit

final class NaviNode: ASDisplayNode {
    
    // MARK: UI
    private let titleNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "식물 결과",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 15.0),
                .foregroundColor: UIColor.gray,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    private let backBtn: ASButtonNode = {
        let node = ASButtonNode()
        node.setTitle("뒤로가기", with: UIFont.boldSystemFont(ofSize: 10.0), with: .black, for: .normal)
        node.addTarget(self, action: #selector(backAction), forControlEvents: .touchUpInside)
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
      var containerInsets: UIEdgeInsets = self.safeAreaInsets
//      containerInsets.left += 15.0
//      containerInsets.right += 15.0
//      containerInsets.top = containerInsets.bottom

      return ASInsetLayoutSpec(
        insets: containerInsets,
        child: self.contentLayoutSpec()
      )
    }

    private func contentLayoutSpec() -> ASLayoutSpec {
      return ASStackLayoutSpec(
        direction: .horizontal,
        spacing: 10.0,
        justifyContent: .start,
        alignItems: .start,
        children: [
          self.backBtn,
          self.titleNode
        ]
      )
    }
}

extension NaviNode {
    
    // MARK: Action
    @objc
    func backAction() {
        print("뒤로가기")
    }
}
