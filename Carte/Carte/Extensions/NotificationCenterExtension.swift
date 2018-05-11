//
//  NotificationCenterExtension.swift
//  creams
//
//  Created by Rawlings on 05/12/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import Foundation

extension NotificationCenter {

    class func registerNotification(_ observer: Any, _ selector: Selector, name: CreamsNotificationName) {
        self.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name.rawValue), object: nil)
    }

    class func postNotification(name: CreamsNotificationName, userInfo: [AnyHashable : Any]?) {
        self.default.post(name: NSNotification.Name(rawValue: name.rawValue), object: nil, userInfo: userInfo)
    }

    class func remove(_ observer: Any) {
        self.default.removeObserver(observer)
    }

    //只适合常驻内存
    class func observe(notificationName: CreamsNotificationName, block: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationName.rawValue), object: nil, queue: OperationQueue.main, using: block)
    }
}

enum CreamsNotificationName: String {
    case selectCartItem = "selectCartItem"
    case selectAddress = "selectAddress"
    case getGoodsDetail = "getGoodsDetail"
    case allReadyComment = "allReadyComment"
}
