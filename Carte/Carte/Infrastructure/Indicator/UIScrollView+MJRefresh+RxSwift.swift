//
//  UIScrollView+MJRefresh+RxSwift.swift
//  creams
//
//  Created by hasayakey on 9/9/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

public extension Reactive where Base: UIScrollView {

    /// 下拉刷新事件
    public var refresh: ControlEvent<Void> {
        base.addPullToRefresh()
        return base.mj_header.rx.componentRefresh
    }

    /// 上拉刷新事件
    public var loadMore: ControlEvent<Void> {
        base.addLoadMoreRefresh()
        return base.mj_footer.rx.componentRefresh
    }

    /// 结束下拉刷新: 是否完全加载完毕
    public var isRefreshing: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: base) { component, isRefreshing in
            if isRefreshing {
                component.pullRefresh()
            } else {
                component.endPullRefresh()
            }
        }
    }

    /// 结束上拉刷新: 是否完全加载完毕
    public var isLoadingMore: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: base) { component, isLoadingMore in
            if !isLoadingMore {
                if component.mj_footer != nil {
                    if component.mj_footer.isRefreshing {
                        component.mj_footer.endRefreshing()
                    }
                }
            }
        }
    }

    public var isNoMoreData: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: self.base) { component, noMoreData in
            component.endPullLoadMore(noMoreData)
        }
    }
}

private var UIScrollViewRefreshKey: UInt8 = 0
private var UIScrollViewUpdateTimeKey: UInt8 = 0

extension UIScrollView {

    func addPullToRefresh(leftEdge: CGFloat? = 0) {
        if mj_header == nil {
            mj_header = RefreshIndicator(color: UIColor.black, leftEdge: leftEdge)
            mj_header.isAutomaticallyChangeAlpha = true
        }
    }

    func addLoadMoreRefresh(leftEdge: CGFloat? = 0) {
        if mj_footer == nil {
            mj_footer = LoadMoreIndicator(color: UIColor.black, leftEdge: leftEdge)
            mj_footer.isAutomaticallyChangeAlpha = true
        }
    }

    fileprivate var _isRefreshing: Bool {
        get {
            return (objc_getAssociatedObject(self, &UIScrollViewRefreshKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &UIScrollViewRefreshKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    fileprivate var _LastUpdateTime: TimeInterval {
        get {
            return (objc_getAssociatedObject(self, &UIScrollViewUpdateTimeKey) as? TimeInterval) ?? 0.0
        }
        set {
            objc_setAssociatedObject(self, &UIScrollViewUpdateTimeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// 1: 如果没有头部,则添加头部; 2: 如果头部和尾部不在刷新,则执行刷新
    func pullRefresh() {

        addPullToRefresh()

        /// 距离上一次刷新的时差必须大于 300毫秒
        let current = Date().timeIntervalSince1970
        guard current - _LastUpdateTime >= 300.0 else {
            return
        }

        _LastUpdateTime = current

        if !_isRefreshing {
            if mj_footer != nil {
                if !mj_footer.isRefreshing {
                    mj_header.beginRefreshing { [weak self] in
                        if let `self` = self {
                            self._isRefreshing = true
                        }
                    }
                }
            } else {
                mj_header.beginRefreshing { [weak self] in
                    if let `self` = self {
                        self._isRefreshing = true
                    }
                }
            }
        }

        if mj_footer != nil {
            mj_footer.resetNoMoreData()
        }
    }

    /// 1: 如果没有头部,则添加头部; 2: 如果头部在刷新,则结束刷新;
    func endPullRefresh() {

        addPullToRefresh()

        if mj_header.isRefreshing {
            mj_header.endRefreshing { [weak self] in
                if let `self` = self {
                    self._isRefreshing = false
                }
            }
        }
    }

    func pullLoadMore() {

        addLoadMoreRefresh()

        if !mj_footer.isRefreshing {
            if mj_header != nil {
                if !mj_header.isRefreshing {
                    mj_footer.beginRefreshing()
                }
            } else {
                mj_footer.beginRefreshing()
            }
        }
    }

    func endPullLoadMore(_ noMoreData: Bool = false) {

        addLoadMoreRefresh()

        if noMoreData {
            mj_footer.endRefreshingWithNoMoreData()
        } else {
            if mj_footer.isRefreshing {
                mj_footer.endRefreshing()
            }
            mj_footer.resetNoMoreData()
        }

        if mj_header != nil {
            if mj_header.isRefreshing {
                mj_header.endRefreshing()
            }
        }
    }
}
