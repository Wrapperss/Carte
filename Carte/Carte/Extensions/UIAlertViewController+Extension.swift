//
//  UIAlertViewController+Extension.swift
//  creams
//
//  Created by Jahov on 09/11/2017.
//  Copyright © 2017 creams.io. All rights reserved.
//

import UIKit
extension UIAlertController {
    
    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach { (action) in
            self.addAction(action)
        }
    }
    
    func addActionsWithCancel(actions: [UIAlertAction]) {
        self.addActions(actions)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        self.addAction(cancelAction)
    }
    
    
    static func showWith(title: String?, message: String?, withCancelAction: Bool, actions: [UIAlertAction], target: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        if withCancelAction {alert.addAction(cancelAction)}
        alert.addActions(actions)
        target.present(alert, animated: true, completion: nil)
    }
}
