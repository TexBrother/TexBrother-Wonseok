//
//  TabBarController.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//
import AsyncDisplayKit

final class TabBarController: ASTabBarController {

    // MARK: UI
    let HomeViewController = PayTabController()
    let PayViewController = PayTabController()
    let OrderViewController = PayTabController()
    let GiftViewController = GiftTabController()
    let OtherViewController = OtherTabController()
    
    // MARK: Main Thread
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarIcons()
        setupTabBar()
    }
}

// MARK: Setup Functions
extension TabBarController: UITabBarControllerDelegate {

    private func setupTabBar(){
        delegate = self
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = UIColor.whiteGrey
        tabBar.tintColor = .seaweedGreen
        configureVCs()
    }

    private func configureVCs(){
        let homeNC = ASNavigationController(rootViewController: HomeViewController).then {
            $0.isNavigationBarHidden = true
        }
        let payNC = ASNavigationController(rootViewController: PayViewController)
        let orderNC = ASNavigationController(rootViewController: OrderViewController)
        let giftNC = ASNavigationController(rootViewController: GiftViewController)
        let otherNC = ASNavigationController(rootViewController: OtherViewController)

        let tabs = [homeNC, payNC, orderNC, giftNC, otherNC]
        self.setViewControllers(tabs, animated: true)
        self.selectedIndex = 1
    }

    private func setTabBarIcons(){
        let homeIcon = UITabBarItem(title: nil, image: Const.TabBar.homeActivated, tag: 0)
        homeIcon.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        HomeViewController.tabBarItem = homeIcon

        let payIcon = UITabBarItem(title: nil, image: Const.TabBar.payActivated, tag: 1)
        payIcon.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        PayViewController.tabBarItem = payIcon

        let orderIcon = UITabBarItem(title: nil, image: Const.TabBar.orderActivated, tag: 2)
        orderIcon.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        OrderViewController.tabBarItem = orderIcon

        let giftIcon = UITabBarItem(title: nil, image: Const.TabBar.giftActivated, tag: 3)
        giftIcon.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        GiftViewController.tabBarItem = giftIcon

        let otherIcon = UITabBarItem(title: nil, image: Const.TabBar.otherActivated, tag: 4)
        otherIcon.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        OtherViewController.tabBarItem = otherIcon
    }
}
