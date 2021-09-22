//
//  TabBarVC.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import AsyncDisplayKit

final class TabBarVC: ASTabBarController {
    // MARK: UI
    let HomeViewController = PayTabController()
    let PayViewController = PayTabController()
    let OrderViewController = PayTabController()
    let GiftViewController = PayTabController()
    let OtherViewController = PayTabController()
    
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
//        tabBar.isTranslucent = false
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = UIColor.secondarySystemBackground
        tabBar.tintColor = .systemGreen
        selectedIndex = 0
        configureVCs()
    }
    
    private func configureVCs(){
        let homeNC = ASNavigationController(rootViewController: HomeViewController)
        homeNC.navigationBar.isHidden = true
        
        let payNC = ASNavigationController(rootViewController: PayViewController)
        payNC.navigationBar.isHidden = true
        
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
        let homeIcon = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        HomeViewController.tabBarItem = homeIcon
        
        let payIcon = UITabBarItem(title: "Pay", image: UIImage(systemName: "creditcard.fill"), tag: 1)
        PayViewController.tabBarItem = payIcon
        
        let orderIcon = UITabBarItem(title: "Other", image: UIImage(systemName: "arrow.up.bin.fill"), tag: 2)
        OrderViewController.tabBarItem = orderIcon
        
        let giftIcon = UITabBarItem(title: "Gift", image: UIImage(systemName: "gift.fill"), tag: 3)
        GiftViewController.tabBarItem = giftIcon
        
        let otherIcon = UITabBarItem(title: "Other", image: UIImage(named: "messageTabIcon.fill"), tag: 4)
        OtherViewController.tabBarItem = otherIcon
    }
}

