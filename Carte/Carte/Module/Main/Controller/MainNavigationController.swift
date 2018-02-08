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
        navigationBar.barTintColor = UIColor.flatBlack
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.flatWhite]
    }
}
