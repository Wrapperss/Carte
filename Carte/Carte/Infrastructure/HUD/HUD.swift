//
//  HUD.swift
//  creams
//
//  Created by Rawlings on 07/12/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import Foundation

@objc class HUD: NSObject {
    
    static let autoClearTime = 1
    
    static var releaseClearTime: Int? {
        #if RELEASE
        return DevHelper.hudClearTimeLong ? 5 : nil
        #else
        return nil
        #endif
    }
    
    class func showSuccess(_ message: String, clearTime: Int = autoClearTime) {
        clear()
        SwiftNotice.showNoticeWithText(NoticeType.success, text: message, autoClear: true, autoClearTime: releaseClearTime ?? clearTime)
    }
    
    class func showError(_ message: String, clearTime: Int = autoClearTime) {
        clear()
        SwiftNotice.showNoticeWithText(NoticeType.error, text: message, autoClear: true, autoClearTime: releaseClearTime ?? clearTime)
    }
    
    class func showInfo(_ message: String, clearTime: Int = autoClearTime) {
        clear()
        SwiftNotice.showNoticeWithText(NoticeType.info, text: message, autoClear: true, autoClearTime: releaseClearTime ?? clearTime)
    }
    
    class func showStar(_ message: String, clearTime: Int = autoClearTime) {
        clear()
        SwiftNotice.showNoticeWithText(NoticeType.star, text: message, autoClear: true, autoClearTime: releaseClearTime ?? clearTime)
    }
    
    class func showDeletion(_ message: String, clearTime: Int = autoClearTime) {
        clear()
        SwiftNotice.showNoticeWithText(NoticeType.deletion, text: message, autoClear: true, autoClearTime: releaseClearTime ?? clearTime)
    }
    
    class func showOnStatusBar(_ message: String, clearTime: Int = autoClearTime) {
        clear()
        SwiftNotice.noticeOnStatusBar(message, autoClear: true, autoClearTime: releaseClearTime ?? clearTime)
    }
    
    class func wait() {
        SwiftNotice.wait()
    }
    
    class func clear() {
        SwiftNotice.clear()
    }
}
