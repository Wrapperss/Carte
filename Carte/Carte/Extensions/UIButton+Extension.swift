//
//  UIButtonExtension.swift
//  creams
//
//  Created by Jahov on 08/12/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit

class ClosureWrapper: NSObject, NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let wrapper: ClosureWrapper = ClosureWrapper()
        wrapper.closure = closure
        return wrapper
    }

    var closure: (() -> Void)?
    convenience init(closure: (() -> Void)?) {
        self.init()
        self.closure = closure
    }
}

extension UIButton {

    private struct AssociatedKeys {
        static var whenTappedKey = "whenTappedKey"
    }

    public func whenTapped(handler: (() -> Void)!) {
        let aBlockClassWrapper = ClosureWrapper(closure: handler)
        objc_setAssociatedObject(self, &AssociatedKeys.whenTappedKey, aBlockClassWrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        self.addTarget(self, action: #selector(UIButton.touchUpInside), for: UIControlEvents.touchUpInside)
    }

    func touchUpInside() {
        let actionBlockAnyObject = objc_getAssociatedObject(self, &AssociatedKeys.whenTappedKey) as? ClosureWrapper
        actionBlockAnyObject?.closure?()
        self.tag = 0
    }
    
}

class NavigationButton: UIButton {
    var alignmentRectInsetsOverride: UIEdgeInsets?
    override var alignmentRectInsets: UIEdgeInsets {
        return alignmentRectInsetsOverride ?? super.alignmentRectInsets
    }
    
    static func create(offset: CGFloat = 0, image: UIImage?, action: @escaping () -> ()) -> UIButton {
        let button = NavigationButton(frame: CGRect(x:0, y: 0, width: 24, height: 24))
        button.setImage(image, for: .normal)
        button.alignmentRectInsetsOverride = UIEdgeInsets(top: 0, left: -offset, bottom: 0, right: offset)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTapAction {
            action()
        }
        return button
    }
}


extension UILabel {

    private struct AssociatedKeys {
        static var whenTappedKey   = "whenTappedKey"
    }

    public func whenTapped(handler: @escaping () -> Void) {
        let aBlockClassWrapper = ClosureWrapper(closure: handler)
        objc_setAssociatedObject(self, &AssociatedKeys.whenTappedKey, aBlockClassWrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(UIButton.touchUpInside))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    func touchUpInside() {
        let actionBlockAnyObject = objc_getAssociatedObject(self, &AssociatedKeys.whenTappedKey) as? ClosureWrapper
        actionBlockAnyObject?.closure?()
        self.tag = 0
    }
}

extension UITextField {

    private struct AssociatedKeys {
        static var whenTappedKey   = "whenTappedKey"
    }

    public func whenTapped(handler: @escaping () -> Void) {
        let aBlockClassWrapper = ClosureWrapper(closure: handler)
        objc_setAssociatedObject(self, &AssociatedKeys.whenTappedKey, aBlockClassWrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        self.addTarget(self, action: #selector(UIButton.touchUpInside), for: UIControlEvents.touchUpInside)
    }

    func touchUpInside() {
        let actionBlockAnyObject = objc_getAssociatedObject(self, &AssociatedKeys.whenTappedKey) as? ClosureWrapper
        actionBlockAnyObject?.closure?()
        self.tag = 0
    }
}

extension UIImageView {

    private struct AssociatedKeys {
        static var whenTappedKey   = "whenTappedKey"
    }

    public func whenTapped(handler: @escaping () -> Void) {
        let aBlockClassWrapper = ClosureWrapper(closure: handler)
        objc_setAssociatedObject(self, &AssociatedKeys.whenTappedKey, aBlockClassWrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(UIButton.touchUpInside))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    func touchUpInside() {
        let actionBlockAnyObject = objc_getAssociatedObject(self, &AssociatedKeys.whenTappedKey) as? ClosureWrapper
        actionBlockAnyObject?.closure?()
        self.tag = 0
    }
}
