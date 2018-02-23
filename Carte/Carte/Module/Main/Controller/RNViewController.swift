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
    
    private static let BaseUrl: String = "http://localhost:8081/"
    private var fileUrl: String = ""
    private var initProps: Dictionary<String, Any>? = nil
    private var isDev: Bool = false
    
    init(fileUrl: String, initProps: Dictionary<String, Any>?, isDev: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        self.fileUrl = fileUrl
        self.initProps = initProps
        self.isDev = isDev
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlString = ""
        urlString = urlString.appending(RNViewController.BaseUrl).appending("\(fileUrl).bundle?platform=ios")
        if isDev {
            urlString = urlString.appending("&dev=true")
        }
        let url = URL(string: urlString)
        let rootView = RCTRootView(bundleURL: url, moduleName: "Carte", initialProperties: initProps, launchOptions: nil)
        self.view = rootView
    }
}

