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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tabBar.tintColor = UIColor.black
    }
    
    private func setup() {
        let 精选 = HomeViewController().then {
            $0.title = "精选"
            $0.tabBarItem = UITabBarItem(title: "精选", image: UIImage(named: "home"), selectedImage: nil)
        }
        
        let 分类 = ClassifyController().then {
            $0.title = "分类"
            $0.tabBarItem = UITabBarItem(title: "分类", image: UIImage(named: "classify"), selectedImage: nil)
        }

        let 杂志 = MagazineController().then {
            $0.view.backgroundColor = UIColor.flatMint
            $0.title = "杂志"
            $0.tabBarItem = UITabBarItem(title: "杂志", image: UIImage(named: "magazine"), selectedImage: nil)
        }
        
        let 购物车 = CartController().then {
            $0.title = "购物车"
            $0.tabBarItem = UITabBarItem(title: "购物车", image: UIImage(named: "cart"), selectedImage: nil)
        }
        
        let 我 = MineController.initFromStoryboard(name: .mine).then {
            $0.title = "我的"
            $0.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "mine"), selectedImage: nil)
        }
        
        self.viewControllers = [MainNavigationController(rootViewController: 精选),
                                MainNavigationController(rootViewController: 分类),
//                                MainNavigationController(rootViewController: 杂志),
                                MainNavigationController(rootViewController: 购物车),
                                MainNavigationController(rootViewController: 我)]
    }
}
