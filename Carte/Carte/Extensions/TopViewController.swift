//
//  TopViewController.swift
//  creams
//
//  Created by Jahov on 30/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit
import RTRootNavigationController

extension UIViewController {

    class func topViewController() -> UIViewController {
        return self.topViewController(withRootViewController: UIApplication.shared.keyWindow!.rootViewController!)
    }

    class func topViewController(withRootViewController rootViewController: UIViewController) -> UIViewController {
        if (rootViewController is UITabBarController) {
            let tabBarController = (rootViewController as! UITabBarController)
            guard let selectedViewController = tabBarController.selectedViewController else {
                return tabBarController
            }
            return self.topViewController(withRootViewController: selectedViewController)
        } else if (rootViewController is UINavigationController) {
            if rootViewController is RTRootNavigationController {
                let navigationController = (rootViewController as! RTRootNavigationController)
                return self.topViewController(withRootViewController: navigationController.rt_visibleViewController)
            } else {
                let navigationController = (rootViewController as! UINavigationController)
                return self.topViewController(withRootViewController: navigationController.visibleViewController!)
            }
        } else if (rootViewController.presentedViewController != nil) {
            let presentedViewController = rootViewController.presentedViewController
            return self.topViewController(withRootViewController: presentedViewController!)
        } else {
            return rootViewController
        }
    }

    class func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if (rootViewController == nil) { return nil }
        if (rootViewController is UITabBarController) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController is UINavigationController) {
            if rootViewController is RTRootNavigationController {
                return topViewControllerWithRootViewController(rootViewController: (rootViewController as! RTRootNavigationController).rt_visibleViewController)
            } else {
                return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
            }
        } else if (rootViewController.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }

}
