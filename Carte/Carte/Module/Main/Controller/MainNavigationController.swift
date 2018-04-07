//
//  MainNavigationController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/2.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import ChameleonFramework

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        
        navigationBar.tintColor = UIColor.flatBlack
        navigationBar.shadowImage = UIImage()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
