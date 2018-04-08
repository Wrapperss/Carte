//
//  MainTabBarController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import ChameleonFramework
import Then

class MainTabBarController: UITabBarController {
    
    let home = BaseViewController()
    let fenlei = BaseViewController()
    let man = BaseViewController()
    let car = BaseViewController()
    let mine = MineController.initFromStoryboard(name: .mine)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tabBar.tintColor = UIColor.black
    }
    
    private func setup() {
//        let vc1 = HomeViewController().then {
//            $0.title = "精选"
//        }

        let vc1 = RNViewController(fileUrl: "Home/Page", initProps: nil).then {
            $0.title = "精选"
            $0.tabBarItem = UITabBarItem(title: "精选", image: UIImage.init(named: "all"), selectedImage: nil)
        }
        
//        let vc1 = UIViewController().then {
//            $0.title = "精选"
//        }
        
        let vc2 = UIViewController().then {
            $0.view.backgroundColor = UIColor.flatBlue
            $0.title = "分类"
        }

        let vc3 = UIViewController().then {
            $0.view.backgroundColor = UIColor.flatMint
            $0.title = "杂志"
        }
        
        let vc4 = CartController().then {
            $0.title = "购物车"
        }
        
        mine.title = "我的"
        
        self.viewControllers = [MainNavigationController(rootViewController: vc1),
                                MainNavigationController(rootViewController: vc2),
                                MainNavigationController(rootViewController: vc3),
                                MainNavigationController(rootViewController: vc4),
                                MainNavigationController(rootViewController: mine)]
        
//        let tab1 = UITabBarItem(title: "精选", image: UIImage.init(named: "all"), selectedImage: nil)
//
//        self.tabBar.items = [tab1]
    }
}
