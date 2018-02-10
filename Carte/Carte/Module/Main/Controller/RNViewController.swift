//
//  RNViewController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/10.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import React

class RNViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://localhost:8081/App.bundle?platform=ios&dev=true"
        let url = URL(string: urlString)
        let rootView = RCTRootView.init(bundleURL: url, moduleName: "NativeRN", initialProperties: nil, launchOptions: nil)
        self.view = rootView
        
//        let url = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "App", fallbackResource: nil)
//        let rootView = RCTRootView.init(bundleURL: url, moduleName: "NaitiveRN", initialProperties: nil, launchOptions: nil)
//        self.view = rootView
    }
}
