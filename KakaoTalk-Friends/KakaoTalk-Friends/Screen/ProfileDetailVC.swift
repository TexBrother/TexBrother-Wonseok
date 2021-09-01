//
//  ProfileDetailVC.swift
//  KakaoTalk-Friends
//
//  Created by Wonseok Lee on 2021/09/01.
//

import AsyncDisplayKit

final class ProfileDetailVC: ASDKViewController<ASDisplayNode> {
    // MARK: UI
    private lazy var profileImageNode: ASImageNode = {
        let node = ASImageNode()
        node.clipsToBounds = true
        node.contentMode = .scaleAspectFit
        node.style.preferredSize = CGSize(width: 97, height: 97)
        return node
    }()
    
    private lazy var profileNameNode: ASTextNode = {
        let node = ASTextNode()
        node.style.flexShrink = 1.0
        node.maximumNumberOfLines = 1
        return node
    }()
    
    private lazy var separatorNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: self.node.frame.width, height: 1)
        node.backgroundColor = .coolGrey
        return node
    }()
    
    private lazy var dismissBtn: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "profileCloseBtn"), for: .normal)
        return node
    }()
    
    private lazy var chatBtn: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "profileTalkImg"), for: .normal)
//        node.setTitle("나와의 채팅", with: UIFont.systemFont(ofSize: 10, weight: .regular), with: .white, for: .normal)
//        node.contentVerticalAlignment = .center
//        node.contentHorizontalAlignment = .middle
        node.contentEdgeInsets = UIEdgeInsets(top: 22, left: 39, bottom: 22, right: 39)
        return node
    }()
    
    private lazy var editBtn: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "profileEditImg"), for: .normal)
        node.contentEdgeInsets = UIEdgeInsets(top: 22, left: 39, bottom: 22, right: 39)
        return node
    }()
    
    private lazy var storyBtn: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "profileStoryImg"), for: .normal)
        node.contentEdgeInsets = UIEdgeInsets(top: 22, left: 39, bottom: 22, right: 39)
        return node
    }()
    
    
    // MARK: Initializing
    init(_ profileImgName: String, _ userName: String) {
        super.init(node: .init())
        self.node.backgroundColor = .blueGrey
        self.profileImageNode.image = UIImage(named: profileImgName)
        self.profileNameNode.attributedText = NSAttributedString(
            string: userName,
            attributes: [.font: UIFont.systemFont(ofSize: 18.0, weight: .regular),
                         .foregroundColor: UIColor.white]
        )

        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        self.node.onDidLoad({ [weak self] _ in
            self?.dismissBtn.addTarget(self, action: #selector(self?.dismissAction), forControlEvents: .touchUpInside)
            self?.chatBtn.addTarget(self, action: #selector(self?.chatBtnAction), forControlEvents: .touchUpInside)
            self?.editBtn.addTarget(self, action: #selector(self?.editBtnAction), forControlEvents: .touchUpInside)
            self?.storyBtn.addTarget(self, action: #selector(self?.storyBtnAction), forControlEvents: .touchUpInside)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        var dismissInsets = self.node.safeAreaInsets
        dismissInsets.top += 14.0
        dismissInsets.left += 18.0
        let dismissBtnLayout = ASInsetLayoutSpec(insets: dismissInsets, child: dismissBtn)
        
        var majorContentInset = self.node.safeAreaInsets
        majorContentInset.bottom += 14.0
        let majorContentLayout = ASInsetLayoutSpec(insets: majorContentInset, child: majorContentLayoutSpec())
        
        return ASStackLayoutSpec (direction: .vertical, spacing: 0.0, justifyContent: .spaceBetween, alignItems: .start, children: [dismissBtnLayout, majorContentLayout])
    }
    
    private func majorContentLayoutSpec() -> ASLayoutSpec {
        let profileContentLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 8,
            justifyContent: .center,
            alignItems: .center,
            children: [
                profileImageNode,
                profileNameNode
            ]
        )
        
        let bottomContentLayout = ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .center,
            alignItems: .stretch,
            children: [
                chatBtn,
                editBtn,
                storyBtn
            ]
        )
    
        profileContentLayout.style.spacingAfter = 31
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 11,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                profileContentLayout,
                separatorNode,
                bottomContentLayout
            ]
        )
    }
}

extension ProfileDetailVC {
    // MARK: ASButtonNode Actions
    @objc
    private func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func chatBtnAction() {
        print("Chat Button Tapped")
    }
    
    @objc
    private func editBtnAction() {
        print("Edit Button Tapped")
    }
    
    @objc
    private func storyBtnAction() {
        print("Story Button Tapped")
    }
}
