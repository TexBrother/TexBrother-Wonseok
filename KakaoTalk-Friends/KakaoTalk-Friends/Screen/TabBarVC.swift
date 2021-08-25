//
//  TabBarVC.swift
//  KakaoTalk-Friends
//
//  Created by Wonseok Lee on 2021/08/24.
//

import AsyncDisplayKit

final class TabBarVC: ASTabBarController {
    // MARK: UI
    let MainViewController = MainVC()
    let ChatViewController = ChatVC()
    let SearchViewController = ChatVC()
    let ShopViewController = ChatVC()
    let DetailViewController = ChatVC()
    
    // MARK: Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setTabBarIcons()
    }
}

// MARK: Setup Functions
extension TabBarVC: UITabBarControllerDelegate {
    
    private func setupTabBar(){
        delegate = self
        tabBar.isTranslucent = false
        tabBar.tintColor = .label
        selectedIndex = 0
        configureVCs()
    }
    
    private func configureVCs(){
        let mainNC = ASNavigationController(rootViewController: MainViewController)
        mainNC.navigationBar.isHidden = true
        
        let chatNC = ASNavigationController(rootViewController: ChatViewController)
        chatNC.navigationBar.isHidden = true
        
        let searchNC = ASNavigationController(rootViewController: SearchViewController)
        searchNC.navigationBar.isHidden = true
        
        let shopNC = ASNavigationController(rootViewController: ShopViewController)
        shopNC.navigationBar.isHidden = true
        
        let showMoreNC = ASNavigationController(rootViewController: DetailViewController)
        showMoreNC.navigationBar.isHidden = true
        
        let tabs = [mainNC, chatNC, searchNC, shopNC, showMoreNC]
        self.setViewControllers(tabs, animated: true)
    }
    
    private func setTabBarIcons(){
        let mainIcon = UITabBarItem(title: nil, image: UIImage(named: "friendTabIcon"), selectedImage: UIImage(named: "friendTabIconSelected") )
        MainViewController.tabBarItem = mainIcon
        
        let chatIcon = UITabBarItem(title: nil, image: UIImage(named: "messageTabIcon"), selectedImage: UIImage(named: "messageTabIconSelected") )
        ChatViewController.tabBarItem = chatIcon
        
        let searchIcon = UITabBarItem(title: nil, image: UIImage(named: "searchTabIcon"), selectedImage: UIImage(named: "searchTabIconSelected") )
        SearchViewController.tabBarItem = searchIcon
        
        let shopNC = UITabBarItem(title: nil, image: UIImage(named: "shopTabIcon"), selectedImage: UIImage(named: "shopTabIconSelected") )
        ShopViewController.tabBarItem = shopNC
        
        let detailIcon = UITabBarItem(title: nil, image: UIImage(named: "detailTabIcon"), selectedImage: UIImage(named: "detailTabIconSelected") )
        DetailViewController.tabBarItem = detailIcon
    }
}
