//
//  UIViewController+Loading+RxSwift.swift
//  creams
//
//  Created by hasayakey on 8/30/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import RxSwift
import RxCocoa
import NVActivityIndicatorView

private var loadingIndicatorKey: UInt8 = 0

public extension Reactive where Base: UIViewController {

    public var isLoading: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: self.base) { component, loading in
            if loading {
                component.startLoading()
            } else {
                component.stopLoading()
            }
        }
    }

    public var isWaiting: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: self.base) { component, loading in
            if loading {
                component.startLoading(backgroundColor: .clear)
            } else {
                component.stopLoading()
            }
        }
    }
}

protocol Loading {
    var attachEdgeInsets: UIEdgeInsets { get }
    var attachView: UIView { get }

    var activityAnimationType: NVActivityIndicatorType { get }
    var activitySize: CGSize { get }
    var activityTintColor: UIColor { get }
    var activityBackgroundColor: UIColor { get }
    var activityData: NVActivityLoadingActivityData { get }
}

extension UIViewController: Loading {

    var attachEdgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    var attachView: UIView {
        return view
    }

    var activityAnimationType: NVActivityIndicatorType {
        return .ballRotateChase
    }

    var activitySize: CGSize {
        return CGSize(width: 30, height: 30)
    }

    var activityTintColor: UIColor {
        return .charcoalGrey
    }

    var activityBackgroundColor: UIColor {
        return .backgroundColor
    }

    var activityData: NVActivityLoadingActivityData {

        return NVActivityLoadingActivityData(attachView: attachView,
                                             attachEdgeInsets: attachEdgeInsets,
                                             size: activitySize,
                                             message: nil,
                                             messageFont: nil,
                                             type: activityAnimationType,
                                             color: activityTintColor,
                                             padding: nil,
                                             displayTimeThreshold: 0.0,
                                             minimumDisplayTime: 0.3,
                                             backgroundColor: activityBackgroundColor,
                                             textColor: nil)
    }

    public final func startLoading() {
        if isViewLoaded {
            let data = activityData
            data.restorationIdentifier = "\(self)"
            loadingIndicator?.startAnimating(data)
        }
    }

    public final func startLoading(backgroundColor: UIColor) {
        if isViewLoaded {
            let data = activityData
            data.backgroundColor = backgroundColor
            data.restorationIdentifier = "\(self)"
            loadingIndicator?.startAnimating(data)
        }
    }

    /**
     Remove UI blocker.
     */
    public final func stopLoading() {
        loadingIndicator?.stopAnimating()
        loadingIndicator = nil
    }

    var loadingIndicator: NVActivityLoadingIndicator? {
        get {
            guard let loadingView = objc_getAssociatedObject(self, &loadingIndicatorKey) as? NVActivityLoadingIndicator else {
                let loadingView = NVActivityLoadingIndicator(frame: .zero)
                objc_setAssociatedObject(self, &loadingIndicatorKey, loadingView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return loadingView
            }
            return loadingView
        }
        set {
            objc_setAssociatedObject(self, &loadingIndicatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

/// Class packages information used to display UI blocker.
final class NVActivityLoadingActivityData {

    var restorationIdentifier: String = "NVActivityIndicatorViewContainer"

    /// 整个视图的尺寸
    weak var attachView: UIView?

    let attachEdgeInsets: UIEdgeInsets

    /// Size of activity indicator view.
    let size: CGSize

    /// Message displayed under activity indicator view.
    let message: String?

    /// Font of message displayed under activity indicator view.
    let messageFont: UIFont

    /// Animation type.
    let type: NVActivityIndicatorType

    /// Color of activity indicator view.
    let color: UIColor

    /// Color of text.
    let textColor: UIColor

    /// Padding of activity indicator view.
    let padding: CGFloat

    /// Display time threshold to actually display UI blocker.
    let displayTimeThreshold: Double

    /// Minimum display time of UI blocker.
    let minimumDisplayTime: Double

    /// Background color of the UI blocker
    var backgroundColor: UIColor

    /**
     Create information package used to display UI blocker.
     
     Appropriate NVActivityIndicatorView.DEFAULT_* values are used for omitted params.
     
     - parameter size:                 size of activity indicator view.
     - parameter message:              message displayed under activity indicator view.
     - parameter messageFont:          font of message displayed under activity indicator view.
     - parameter type:                 animation type.
     - parameter color:                color of activity indicator view.
     - parameter padding:              padding of activity indicator view.
     - parameter displayTimeThreshold: display time threshold to actually display UI blocker.
     - parameter minimumDisplayTime:   minimum display time of UI blocker.
     - parameter textColor:            color of the text below the activity indicator view. Will match color parameter if not set, otherwise DEFAULT_TEXT_COLOR if color is not set.
     
     - returns: The information package used to display UI blocker.
     */
    public init(attachView: UIView? = nil,
                attachEdgeInsets: UIEdgeInsets,
                size: CGSize? = nil,
                message: String? = nil,
                messageFont: UIFont? = nil,
                type: NVActivityIndicatorType? = nil,
                color: UIColor? = nil,
                padding: CGFloat? = nil,
                displayTimeThreshold: Double? = nil,
                minimumDisplayTime: Double? = nil,
                backgroundColor: UIColor? = nil,
                textColor: UIColor? = nil) {

        self.attachView = attachView
        self.attachEdgeInsets = attachEdgeInsets
        self.size = size ?? CGSize(width: 50, height: 50)
        self.message = message
        self.messageFont = messageFont ?? .systemFont(ofSize: 13)
        self.type = type ?? .ballRotateChase
        self.color = color ?? UIColor(white: 0.0, alpha: 1.0)
        self.padding = padding ?? 0
        self.displayTimeThreshold = displayTimeThreshold ?? 0.0
        self.minimumDisplayTime = minimumDisplayTime ?? 0.0
        self.backgroundColor = backgroundColor ??  UIColor(white: 1.0, alpha: 1.0)
        self.textColor = textColor ?? color ?? UIColor(white: 0.0, alpha: 1.0)
    }
}

/// Presenter that displays NVActivityIndicatorView as UI blocker.
final class NVActivityLoadingIndicator: UIView {

    private enum State {
        case waitingToShow
        case showed
        case waitingToHide
        case hidden
    }

    private var state: State = .hidden

    deinit {
        print("NVActivityLoadingIndicator deinit")
    }

    // MARK: - Public interface

    /**
     Display UI blocker.
     
     - parameter data: Information package used to display UI blocker.
     */
    public final func startAnimating(_ data: NVActivityLoadingActivityData) {
        guard state == .hidden else { return }

        state = .waitingToShow
        self.show(with: data)
    }

    /**
     Remove UI blocker.
     */
    public final func stopAnimating() {
        _hide()
    }

    // MARK: - Helpers

    private func show(with activityData: NVActivityLoadingActivityData) {

        backgroundColor = activityData.backgroundColor
        restorationIdentifier = activityData.restorationIdentifier
        translatesAutoresizingMaskIntoConstraints = false

        let activityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: activityData.size.width, height: activityData.size.height),
            type: activityData.type,
            color: activityData.color,
            padding: activityData.padding)

        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        bringSubview(toFront: activityIndicatorView)

        // Add constraints for `activityIndicatorView`.
        ({
            let xConstraint = NSLayoutConstraint(item: self,
                                                 attribute: .centerX,
                                                 relatedBy: .equal,
                                                 toItem: activityIndicatorView,
                                                 attribute: .centerX,
                                                 multiplier: 1,
                                                 constant: 0)
            let yConstraint = NSLayoutConstraint(item: self,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: activityIndicatorView,
                                                 attribute: .centerY,
                                                 multiplier: 1,
                                                 constant: 0)

            addConstraints([xConstraint, yConstraint])
        }())

        guard let attachView = activityData.attachView else {
            return
        }

        attachView.addSubview(self)
        state = .showed

        // Add constraints for `containerView`.
        ({
            let leadingConstraint = NSLayoutConstraint(item: attachView,
                                                       attribute: .leading,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .leading,
                                                       multiplier: 1,
                                                       constant: -activityData.attachEdgeInsets.left)
            let trailingConstraint = NSLayoutConstraint(item: attachView,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: self,
                                                        attribute: .trailing,
                                                        multiplier: 1,
                                                        constant: activityData.attachEdgeInsets.right)
            let topConstraint = NSLayoutConstraint(item: attachView,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .top,
                                                   multiplier: 1,
                                                   constant: -activityData.attachEdgeInsets.top)
            let bottomConstraint = NSLayoutConstraint(item: attachView,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: self,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: activityData.attachEdgeInsets.bottom)

            attachView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        }())

        DispatchQueue.main.asyncAfter(deadline: .now() + activityData.minimumDisplayTime) {
            self._hide()
        }
    }

    private func _hide() {
        if state == .waitingToHide {
            hide()
        } else if state != .hidden {
            state = .waitingToHide
        }
    }

    private func hide() {

        UIView.animate(withDuration: 0.68, animations: {
            self.alpha = 0
        }, completion: { (finished) in
            if finished {
                self.removeFromSuperview()
            }
        })
        state = .hidden
    }
}
