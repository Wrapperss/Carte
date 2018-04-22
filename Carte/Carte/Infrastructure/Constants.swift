//
//  Constants.swift
//  creams
//
//  Created by Jahov on 28/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import Foundation

struct Constants {
    static let pageLimit: Int = 20
    static let requestDateFormatter = "yyyy-MM-dd"
    
    struct APIKey {
        
        static let koopaURL = "https://koopa-api.creams.io/mobile/"
        static let marioURL = "https://mario-api.creams.io/mobile/"
        static let upyunRootURL = "https://creams.b0.upaiyun.com/"
        static var betaURL = "https://rc-api.creams.io/mobile/"
        static var releaseURL = "https://api.creams.io/mobile/"
        static let demoURL = "https://api-demo.creams.io/mobile/"
        static let demoDevURL = "https://api-demo-beta.creams.io/mobile/"
        static let stagingURL = "https://staging-api.creams.io/mobile/"
        static let citicUrl = "http://47.94.154.222:9171/mobile/"
        
        #if DEBUG || RELEASE
        static let microBookUrl = "https://rc-www.creams.io/microBuilding"
        #else
        static let microBookUrl = "https://www.creams.io/microBuilding"
        #endif
        static var serverURL: String {
            get {
                #if DEBUG || RELEASE
//                if let value = Default.Constants.string(forKey: .serverURL) {
//                    return value
//                }
                return citicUrl
                #elseif PREVIEW
                return citicUrl
                #else
                return citicUrl
                #endif
            }
            set {
//                Default.Constants.set(newValue, forKey: .serverURL)
            }
        }
    }
    
    struct ServiceKey {
        static let GrowingIOKey = "aada947d099aac15"
        static let UMengAppKey = ""
        static let FirKey = "93fe440b0c2371550f57b088ce04a6da"
        
        #if DEBUG || RELEASE
        static let pushKey = "GHmVLxD5xfTNGC4Is1sZkIx6OHwaOty4"
        static let mapKey = "he9B07Sm8KDs2xfTWm6BlkCA4D2Yy9zp"
        #elseif PREVIEW
        static let pushKey = "GHmVLxD5xfTNGC4Is1sZkIx6OHwaOty4"
        static let BuglyID = "311dd98500"
        static let mapKey = "SX3giWtSwDu7fV75SUKp98lK9O9sLW1n"
        #elseif APPSTORE
        static let pushKey = ""
        static let BuglyID = "4c8082e3e6"
        static let mapKey = "SX3giWtSwDu7fV75SUKp98lK9O9sLW1n"
        #endif
    }
    
    struct Scheme {
        static let creams = "creams"
        static let weibo = "wb783935141"
        static let qq = "QQ41eae04b"
        static let weixin = "weixinScheme"
    }
}
