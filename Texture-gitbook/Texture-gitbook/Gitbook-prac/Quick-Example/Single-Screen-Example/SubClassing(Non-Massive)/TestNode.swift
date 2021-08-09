//
//  TestNode.swift
//  Texture-gitbook
//
//  Created by Wonseok Lee on 2021/08/09.
//  https://texture-kr.gitbook.io/wiki/newbie-guide/quick-example

// MARK: 2. Container에 들어갈 노드를 Subclass 화 시켜서 넣어주기. (Avoid Massive ViewController)
/**
 ASViewController는 제네릭형태로 ASDisplayNode의 모든 Subclass를 받아서 사용할 수 있습니다.
 따라서 아래의 코드와 같이 ViewController에 들어갈 화면 구성요소들을 모듈화 시켜서 ViewController가 Massive해지는 것을 피할 수도 있습니다.
 */

import AsyncDisplayKit

final class TestNode: ASDisplayNode {

  // MARK: UI
  
  private let imageNode: ASImageNode = {
    let node = ASImageNode()
    node.image = UIImage(named: "texBrother")
    node.borderColor = UIColor.gray.cgColor
    node.borderWidth = 1.0
    node.cornerRadius = 15.0
    node.contentMode = .scaleAspectFit
    return node
  }()

  private let titleNode: ASTextNode = {
    let node = ASTextNode()
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    node.attributedText = NSAttributedString(
      string: "Welcome to TexBrother!",
      attributes: [
        .font: UIFont.boldSystemFont(ofSize: 15.0),
        .foregroundColor: UIColor.gray,
        .paragraphStyle: paragraphStyle
      ]
    )
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
    self.imageNode.cornerRadius = 15.0
  }
  
  
  // MARK: Layout

  override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
    var containerInsets: UIEdgeInsets = self.safeAreaInsets
    containerInsets.left += 15.0
    containerInsets.right += 15.0
    containerInsets.top = containerInsets.bottom

    return ASInsetLayoutSpec(
      insets: containerInsets,
      child: self.contentLayoutSpec()
    )
  }

  private func contentLayoutSpec() -> ASLayoutSpec {
    return ASStackLayoutSpec(
      direction: .vertical,
      spacing: 10.0,
      justifyContent: .center,
      alignItems: .center,
      children: [
        self.imageLayoutSpec(),
        self.titleNode
      ]
    )
  }

  private func imageLayoutSpec() -> ASLayoutSpec {
    return ASRatioLayoutSpec(ratio: 1.0, child: self.imageNode).styled {
      $0.flexShrink = 1.0
    }
  }
}
