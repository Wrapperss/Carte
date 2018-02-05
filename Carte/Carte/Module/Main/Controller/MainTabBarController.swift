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
    let mine = MineController(viewModel: MineViewModel())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tabBar.tintColor = UIColor.black
    }
    
    private func setup() {
        let vc1 = UIViewController().then {
            $0.view.backgroundColor = UIColor.flatLime
            $0.title = "精选"
        }
        
        let vc2 = UIViewController().then {
            $0.view.backgroundColor = UIColor.flatBlue
            $0.title = "分类"
        }

        let vc3 = UIViewController().then {
            $0.view.backgroundColor = UIColor.flatMint
            $0.title = "慢用"
        }
        
        let vc4 = UIViewController().then {
            $0.view.backgroundColor = UIColor.flatGray
            $0.title = "购物车"
        }

        let mine = MineController().then {
            $0.title = "我的"
        }
        
        self.viewControllers = [MainNavigationController(rootViewController: vc1),
                                MainNavigationController(rootViewController: vc2),
                                MainNavigationController(rootViewController: vc3),
                                MainNavigationController(rootViewController: vc4),
                                MainNavigationController(rootViewController: mine)]
    }
}
