//
//  TestCellNode.swift
//  Texture-gitbook
//
//  Created by Wonseok Lee on 2021/08/09.
//  https://texture-kr.gitbook.io/wiki/newbie-guide/quick-example

// MARK: List Screen Example
/**
 앞서 설명했듯이 ASViewController는 제네릭형태로 ASDisplayNode의 모든 Subclass를 받아서 사용할 수 있습니다.
 ASTableNode는 ASDisplayNode의 subclass이므로 ASViewController를 만들때 ASVIewController<ASTableNode> 를 상속받아 ViewController를 만듭니다.
 */

import AsyncDisplayKit

final class TestCellNode: ASCellNode {

  // MARK: UI
  private let imageNode: ASImageNode = {
    let node = ASImageNode()
    node.image = UIImage(named: "texBrother")
    node.borderColor = UIColor.gray.cgColor
    node.borderWidth = 1.0
    node.contentMode = .scaleAspectFit
    return node
  }()

  private let titleNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    return node
  }()


  // MARK: Initializing
  init(item: String) {
    super.init()
    self.automaticallyManagesSubnodes = true
    self.selectionStyle = .none
    self.backgroundColor = .white
    self.titleNode.attributedText = NSAttributedString(
      string: item,
      attributes: [
        .font: UIFont.boldSystemFont(ofSize: 15.0),
        .foregroundColor: UIColor.gray
      ]
    )
  }


  // MARK: Node Life Cycle
  override func layout() {
    super.layout()
    self.imageNode.cornerRadius = 15.0
  }


  // MARK: Layout
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    return ASInsetLayoutSpec(
      insets: UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0),
      child: self.contentLayoutSpec()
    )
  }

  private func contentLayoutSpec() -> ASLayoutSpec {
    return ASStackLayoutSpec(
      direction: .horizontal,
      spacing: 10.0,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        self.imageLayoutSpec().styled {
          $0.flexBasis =  ASDimension(unit: .fraction, value: 0.3)
        },
        self.titleNode.styled {
          $0.flexBasis =  ASDimension(unit: .fraction, value: 0.7)
        }
      ]
    )
  }

  private func imageLayoutSpec() -> ASLayoutSpec {
    return ASRatioLayoutSpec(ratio: 1.0, child: self.imageNode)
  }
}
