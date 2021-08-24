//
//  ChatVC.swift
//  KakaoTalk-Friends
//
//  Created by Wonseok Lee on 2021/08/24.
//

import AsyncDisplayKit

final class ChatVC: ASDKViewController<ASDisplayNode> {    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init() {
        super.init(node: .init())
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
