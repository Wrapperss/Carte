//
//  MainTabBarController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import ChameleonFramework

class MainTabBarController: UITabBarController {
    
    let home = BaseViewController()
    let fenlei = BaseViewController()
    let man = BaseViewController()
    let car = BaseViewController()
    let mine = MineController(viewModel: MineViewModel())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        //精选
        home.view.backgroundColor = UIColor.flatMint
        addVC(tabBarItem: UITabBarItem(title: "精选", image: nil, selectedImage: nil), viewController: home)
        //分类
        fenlei.view.backgroundColor = UIColor.flatRed
        addVC(tabBarItem: UITabBarItem(title: "分类", image: nil, selectedImage: nil), viewController: fenlei)
        //慢用
        fenlei.view.backgroundColor = UIColor.flatBlue
        addVC(tabBarItem: UITabBarItem(title: "慢用", image: nil, selectedImage: nil), viewController: man)
        //购物车
        car.view.backgroundColor = UIColor.flatLime
        addVC(tabBarItem: UITabBarItem(title: "购物车", image: nil, selectedImage: nil), viewController: car)
        //我的
        addVC(tabBarItem: UITabBarItem(title: "我的", image: nil, selectedImage: nil), viewController: mine)
    }
    
    private func addVC(tabBarItem item: UITabBarItem,  viewController vc: BaseViewController) {
        vc.tabBarItem = item
        if viewControllers == nil {
            viewControllers = [UIViewController]()
        }
        viewControllers?.append(vc)
    }
}
