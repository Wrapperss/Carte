//
//  HUD.swift
//  creams
//
//  Created by Rawlings on 07/12/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import RxSwift
import RxCocoa
import SVProgressHUD

public final class HUD: NSObject {

    static let `default`: HUD = {
        return HUD()
    }()

    public func showError(_ message: String?, clearTime: TimeInterval = autoDismissTime) {
        if let message = message {
            HUD.showError(message, clearTime: clearTime)
        }
    }

    public func wait() {
        HUD.wait()
    }

    public func clear() {
        HUD.clear()
    }

    static let autoDismissTime: TimeInterval = 0.5

    static func defaultDeploy() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setMinimumSize(.zero)
        SVProgressHUD.setCornerRadius(5.0)
        SVProgressHUD.setFont(.systemFont(ofSize: 14))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor(white: 0, alpha: 0.6))
        SVProgressHUD.setSuccessImage(UIImage(named: "HUD_Success")!)
        SVProgressHUD.setErrorImage(UIImage(named: "HUD_Error")!)
        SVProgressHUD.setMinimumDismissTimeInterval(autoDismissTime)
        SVProgressHUD.setMaximumDismissTimeInterval(3)
        SVProgressHUD.setFadeInAnimationDuration(0.15)
        SVProgressHUD.setFadeOutAnimationDuration(0.15)
        SVProgressHUD.setMaxSupportedWindowLevel(UIWindowLevelAlert)
    }

    static func showSuccess(_ message: String, clearTime: TimeInterval = autoDismissTime) {

//        if #available(iOS 10.0, *) {
//            let taptic = UIImpactFeedbackGenerator(style: .heavy)
//            taptic.prepare()
//            taptic.impactOccurred()
//        }

        HUD.updateMiniSize()
        SVProgressHUD.showSuccess(withStatus: message)
        if clearTime != autoDismissTime {
            SVProgressHUD.dismiss(withDelay: clearTime)
        }
    }

    static func showError(_ message: String, clearTime: TimeInterval = autoDismissTime) {

        if #available(iOS 10.0, *) {
            let taptic = UIImpactFeedbackGenerator(style: .heavy)
            taptic.prepare()
            taptic.impactOccurred()
        }

        HUD.updateMiniSize()
        SVProgressHUD.showError(withStatus: message)
        if clearTime != autoDismissTime {
            SVProgressHUD.dismiss(withDelay: clearTime)
        }
    }

    static func showInfo(_ message: String, clearTime: TimeInterval = autoDismissTime) {
        HUD.updateMiniSize()
        SVProgressHUD.showInfo(withStatus: message)
        if clearTime != autoDismissTime {
            SVProgressHUD.dismiss(withDelay: clearTime)
        }
    }

    static func showStar(_ message: String, clearTime: TimeInterval = autoDismissTime) {
        HUD.updateMiniSize()
        SVProgressHUD.show(UIImage(named: "HUD_Star")!, status: message)
        if clearTime != autoDismissTime {
            SVProgressHUD.dismiss(withDelay: clearTime)
        }
    }

    static func showDeletion(_ message: String, clearTime: TimeInterval = autoDismissTime) {
        HUD.updateMiniSize()
        SVProgressHUD.show(UIImage(named: "HUD_deletion")!, status: message)
        if clearTime != autoDismissTime {
            SVProgressHUD.dismiss(withDelay: clearTime)
        }
    }

    private static func updateMiniSize(_ update: Bool = true) {
        if update {
            SVProgressHUD.setMinimumSize(CGSize(width: 150, height: 100))
            SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))
        } else {
            SVProgressHUD.setMinimumSize(.zero)
            SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))
        }
    }

    static func wait() {
        HUD.updateMiniSize(false)
        SVProgressHUD.show()
    }
    
    static func wait(info: String) {
        HUD.updateMiniSize(false)
        SVProgressHUD.showInfo(withStatus: info)
        
    }

    static func clear() {
        SVProgressHUD.dismiss()
    }

}

public extension Reactive where Base: HUD {

    public var showError: UIBindingObserver<Base, String?> {
        return UIBindingObserver(UIElement: self.base) { component, error in
            component.showError(error)
        }
    }

    public var showWait: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: self.base) { component, waiting in
            if waiting {
                component.wait()
            } else {
                component.clear()
            }
        }
    }
}
