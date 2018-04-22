//
//  UIViewExtension.swift
//  creams
//
//  Created by Rawlings on 23/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit

private var innerTapActionKey: UInt8 = 0
private var innerTapActionParametricKey: UInt8 = 0

protocol ReusableView: class { }

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(self)
    }
}

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(self)
    }
}

extension UIView: ReusableView { }

extension UIView: NibLoadableView { }

extension UIView {

    class func getNib() -> UINib {
        return UINib(nibName: String(self), bundle: nil)
    }

    class func initFromNib() -> Self {
        return Bundle.loadNib(self)
    }
}

extension Bundle {
    class func loadNib<T>(_ Type: T.Type) -> T {
        let identifier = "\(String(describing: T.self))".components(separatedBy: ".").first!
        return (self.main.loadNibNamed(identifier, owner: self, options: nil)?[0] as? T)!
    }
}

extension UIView {

    class Animator {

        typealias Animations = () -> Void
        typealias Completion = (Bool) -> Void

        private var animations: Animations
        private var completion: Completion?
        private let duration: TimeInterval

        init(duration: TimeInterval) {
            self.animations = {}
            self.completion = nil
            self.duration = duration
        }

        func animations(_ animations: @escaping Animations) -> Self {
            self.animations = animations
            return self
        }

        func completion(_ completion: @escaping Completion) -> Self {
            self.completion = completion
            return self
        }

        func animate() {
            UIView.animate(withDuration: duration,
                           animations: animations,
                           completion: completion)
        }
    }
}

extension UIView {
    
    public func findSubviews<T: UIView>(_ viewClass: T.Type) -> [T] {
        return subviews.flatMap { $0 as? T }
    }
    
    public func findSubviews<T: UIView>(_ predicate: (T)->(Bool)) -> [T] {
        return subviews.flatMap {
            guard let t = $0 as? T else {
                return nil
            }
            return predicate(t) ? t : nil
        }
    }
    
    @discardableResult
    public func findSubviewsRecursive<T: UIView>(_ viewClass: T.Type) -> [T] {
        let store = findSubviews(viewClass)
        return subviews.reduce(into: store, { return $0.appending(contentOf: $1.findSubviewsRecursive(viewClass)) })
    }
    
    @discardableResult
    public func findSubviewsRecursive<T: UIView>(_ predicate: (T)->(Bool)) -> [T] {
        let store = findSubviews(predicate)
        return subviews.reduce(into: store, { return $0.appending(contentOf: $1.findSubviewsRecursive(predicate)) })
    }
    
}

extension UIView {

    /// 裁剪 view 的圆角
    func clipRectCorner(_ direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
}

extension UIView {

    func addTapAction(action: (() -> Void)?) {
        innerTapAction = action
        let tap = UITapGestureRecognizer(target: self, action: #selector(executeTapAction))
        addGestureRecognizer(tap)
    }
    
    func addTapActionParametric(action: ((UIView) -> Void)?) {
        innerTapActionParametric = action
        let tap = UITapGestureRecognizer(target: self, action: #selector(executeTapActionParametric(_:)))
        addGestureRecognizer(tap)
    }

    func executeTapAction() {
        innerTapAction?()
    }
    
    func executeTapActionParametric(_ gesture: UIGestureRecognizer) {
        if let view = gesture.view {
            innerTapActionParametric?(view)
        }
    }
}

extension UIView {

    var innerTapAction:(() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &innerTapActionKey) as? () -> Void
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self, &innerTapActionKey, newValue as () -> Void, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
    }
    
    var innerTapActionParametric:((UIView) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &innerTapActionParametricKey) as? (UIView) -> Void
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self, &innerTapActionParametricKey, newValue as (UIView) -> Void, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
    }
}

// MARK: - Extended Rotation
extension UIView {

    var isRotating: Bool {
        return layer.animation(forKey: "extendedRotation") != nil
    }

    func startRotate() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = 1.0
        rotateAnimation.repeatCount = MAXFLOAT
        layer.add(rotateAnimation, forKey: "extendedRotation")
    }

    func stopRotate() {
        layer.removeAnimation(forKey: "extendedRotation")
    }

    func rotate180() {
        UIView.animate(withDuration: 0.2, animations: {
            let angle = self.tag == 1 ? 0 : CGFloat.pi
            self.transform = CGAffineTransform(rotationAngle: angle)
            self.tag = self.tag == 1 ? 0 : 1
        })
    }

    func addBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }

}

// MARK: Frame Extensions

extension UIView {

    /// EZSwiftExtensions, add multiple subviews
    public func addSubviews(_ views: [UIView]) {
        views.forEach { eachView in
            self.addSubview(eachView)
        }
    }

    //TODO: Add pics to readme
    /// EZSwiftExtensions, resizes this view so it fits the largest subview
    public func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newWidth = aView.x + aView.w
            let newHeight = aView.y + aView.h
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }

    /// EZSwiftExtensions, resizes this view so it fits the largest subview
    public func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.w
                let newHeight = aView.y + aView.h
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }

    /// EZSwiftExtensions
    public func resizeToFitWidth() {
        let currentHeight = self.h
        self.sizeToFit()
        self.h = currentHeight
    }

    /// EZSwiftExtensions
    public func resizeToFitHeight() {
        let currentWidth = self.w
        self.sizeToFit()
        self.w = currentWidth
    }

    /// EZSwiftExtensions
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }

    /// EZSwiftExtensions
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }

    /// EZSwiftExtensions
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }

    /// EZSwiftExtensions
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }

    /// EZSwiftExtensions
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }

    /// EZSwiftExtensions
    public var right: CGFloat {
        get {
            return self.x + self.w
        } set(value) {
            self.x = value - self.w
        }
    }

    /// EZSwiftExtensions
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }

    /// EZSwiftExtensions
    public var bottom: CGFloat {
        get {
            return self.y + self.h
        } set(value) {
            self.y = value - self.h
        }
    }

    /// EZSwiftExtensions
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }

    /// EZSwiftExtensions
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }

    /// EZSwiftExtensions
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }

    /// EZSwiftExtensions
    public var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }

    /// EZSwiftExtensions
    public func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }

    /// EZSwiftExtensions
    public func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }

    /// EZSwiftExtensions
    public func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }

    /// EZSwiftExtensions
    public func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }

    //TODO: Add to readme
    /// EZSwiftExtensions
    public func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.w - offset
    }

    /// EZSwiftExtensions
    public func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }

    public func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    /// EZSE: Centers view in superview horizontally
    public func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }

        self.x = parentView.w / 2 - self.w / 2
    }

    /// EZSE: Centers view in superview vertically
    public func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }

        self.y = parentView.h / 2 - self.h / 2
    }

    /// EZSE: Centers view in superview horizontally & vertically
    public func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }
}

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }

}

extension UIView {

    func addDashedLine(color: UIColor = .lightGray) {
        _ = layer.sublayers?.filter({ $0.name == "DashedTopLine" }).map({ $0.removeFromSuperlayer() })
        backgroundColor = .clear

        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedTopLine"
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [4, 4]

        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        shapeLayer.path = path

        layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    
    class func defaultSpringAnimate (animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        self.animate(withDuration: 0.3,
                     delay: 0,
                     usingSpringWithDamping: 1,
                     initialSpringVelocity: 0,
                     options: UIViewAnimationOptions.curveEaseInOut,
                     animations: animations,
                     completion:completion)
    }
    
    class func dampingSpringAnimate (animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        self.animate(withDuration: 0.3,
                     delay: 0,
                     usingSpringWithDamping: 0.5,
                     initialSpringVelocity: 1,
                     options: UIViewAnimationOptions.curveEaseInOut,
                     animations: animations,
                     completion: completion)
    }
    
    class func movingSpringAnimate (animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        self.animate(withDuration: 0.3,
                     delay: 0,
                     usingSpringWithDamping: 0.9,
                     initialSpringVelocity: 0.5,
                     options: UIViewAnimationOptions.curveEaseInOut,
                     animations: animations,
                     completion: completion)
    }
    
    class func cellExpandSpringAnimate (animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        self.animate(withDuration: 0.5,
                     delay: 0,
                     usingSpringWithDamping: 0.5,
                     initialSpringVelocity: 0.5,
                     options: UIViewAnimationOptions.curveEaseInOut,
                     animations: animations,
                     completion: completion)
    }
    
    class func defaultBackAnimate (animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        self.animate(withDuration: 0.3, animations: animations, completion: completion)
    }
    
}

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    @discardableResult
    func setMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {

        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.identifier = identifier
        newConstraint.isActive = true

        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
