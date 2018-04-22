//
//  BadgeService.swift
//  creams
//
//  Created by Rawlings on 16/03/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation
import UserNotifications

struct BadgeService {
    
    public static var currentBadgeNumber: Int = Default.Account.integer(forKey: Default.Account.IntegerKey.iconBadge)
    
    static func updateCurrentBadgeNumber(_ number: Int) {
        currentBadgeNumber = number
        Default.Account.set(number, forKey: Default.Account.IntegerKey.iconBadge)
    }
    
    static func process() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            content.badge = NSNumber(value: currentBadgeNumber)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
            let request = UNNotificationRequest(identifier: "badgeUpdating", content: content, trigger: trigger)
            center.add(request, withCompletionHandler: nil)
            
        } else {
            UIApplication.shared.cancelAllLocalNotifications()
            let local = UILocalNotification()
            local.fireDate = Date()
            local.timeZone = NSTimeZone.default
            local.repeatInterval = NSCalendar.Unit(rawValue: 0)
            local.applicationIconBadgeNumber = currentBadgeNumber
            UIApplication.shared.scheduleLocalNotification(local)
        }
    }
}
