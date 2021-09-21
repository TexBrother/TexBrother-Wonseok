//
//  TabBarVC.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import AsyncDisplayKit

final class TabBarVC: ASTabBarController {
    // MARK: UI
    let HomeViewController = PayTab()
    let PayViewController = PayTab()
    let OrderViewController = PayTab()
    let GiftViewController = PayTab()
    let OtherViewController = PayTab()
    
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
        let homeNC = ASNavigationController(rootViewController: HomeViewController)
        homeNC.navigationBar.isHidden = true
        
        let payNC = ASNavigationController(rootViewController: PayViewController)
        payNC.navigationController?.navigationBar.prefersLargeTitles = true
        
        let orderNC = ASNavigationController(rootViewController: OrderViewController)
        orderNC.navigationBar.isHidden = true
        
        let giftNC = ASNavigationController(rootViewController: GiftViewController)
        giftNC.navigationBar.isHidden = true
        
        let otherNC = ASNavigationController(rootViewController: OtherViewController)
        otherNC.navigationBar.isHidden = true
        
        let tabs = [homeNC, payNC, orderNC, giftNC, otherNC]
        self.setViewControllers(tabs, animated: true)
    }
    
    private func setTabBarIcons(){
        let mainIcon = UITabBarItem(title: nil, image: UIImage(named: "messageTabIcon"), selectedImage: UIImage(named: "messageTabIconSelected") )
        HomeViewController.tabBarItem = mainIcon
        
        let chatIcon = UITabBarItem(title: nil, image: UIImage(named: "messageTabIcon"), selectedImage: UIImage(named: "messageTabIconSelected") )
        PayViewController.tabBarItem = chatIcon
        
        let searchIcon = UITabBarItem(title: nil, image: UIImage(named: "messageTabIcon"), selectedImage: UIImage(named: "messageTabIconSelected") )
        OrderViewController.tabBarItem = searchIcon
        
        let shopNC = UITabBarItem(title: nil, image: UIImage(named: "messageTabIcon"), selectedImage: UIImage(named: "messageTabIconSelected") )
        GiftViewController.tabBarItem = shopNC
        
        let detailIcon = UITabBarItem(title: nil, image: UIImage(named: "messageTabIcon"), selectedImage: UIImage(named: "messageTabIconSelected") )
        OtherViewController.tabBarItem = detailIcon
    }
}

