//
//  UIScrollViewExtension.swift
//  creams
//
//  Created by Rawlings on 20/12/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit
import MJRefresh

private var pageIndexStartDefault: Int = 1
var pageSizeDefault: Int = 10

private var pageIndexKey: UInt8 = 0

struct PageModel {
    var pageIndex: Int
    var pageSize: Int
    var successHandle: (_ newData: Array<Any>) -> Void
    var errorHandle: () -> Void
}

// MARK: - refresh
extension UIScrollView {

    fileprivate var innerPageIndex: Int? {
        get {
            return objc_getAssociatedObject(self, &pageIndexKey) as? Int
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self, &pageIndexKey, newValue as Int?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

//    @discardableResult
//    func addRefreshAction(pageIndexStart: Int = pageIndexStartDefault, refreshBlock: @escaping (_ pageModel: PageModel) -> Void) -> UIScrollView {
//        self.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            self.innerPageIndex = pageIndexStart
//            if (self.mj_footer != nil) {
//                self.mj_footer.resetNoMoreData()
//            }
//            refreshBlock(PageModel(pageIndex: self.innerPageIndex!, pageSize: pageSizeDefault, successHandle: { (_) in
//
//            }, errorHandle: {
//
//            }))
//        })
//        return self
//    }
//
//    @discardableResult
//    func addLoadMoreAction(loadMoreBlock: @escaping (_ pageModel: PageModel) -> Void) -> UIScrollView {
//
//        mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
//            if var innerPageIndex = self.innerPageIndex {
//                innerPageIndex += 1
//                self.innerPageIndex! += 1
//                loadMoreBlock(PageModel(pageIndex: innerPageIndex, pageSize: pageSizeDefault, successHandle: { (newData) in
//                    if (newData.count < pageSizeDefault) { self.mj_footer.endRefreshingWithNoMoreData() }
//                }, errorHandle: {
//                    innerPageIndex -= 1
//                }))
//            }
//        })
//        mj_footer.isAutomaticallyHidden = true
//        return self
//    }

}

// MARK: - Refresh & LoadMore

extension UIScrollView {
    
//    func addPullToRefresh(target: AnyObject, action: Selector) {
//        self.mj_header = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: action)
//    }

    func addPullToRefreshWithBlock(_ block: @escaping () -> Void) {
        addPullToRefresh(withCustomView: CreamsRefreshView(frame: .zero)) {
            block()
        }
//        self.mj_header = MJRefreshNormalHeader(refreshingBlock: block)
//        self.mj_header.isAutomaticallyChangeAlpha = true
    }

    func addLoadMoreRefreshWithBlock(_ block: @escaping () -> Void) {
        self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: block)
    }

    func beginRefreshing() {
        triggerPullToRefresh()
//        if self.mj_header != nil && !self.mj_header.isRefreshing() {
//            self.mj_header.beginRefreshing()
//        }
    }

    func endRefreshing() {
        if isRefreshing {
            pullToRefreshView.stopAnimating()
        }
//        if self.mj_header != nil && self.mj_header.isRefreshing() {
//            self.mj_header.endRefreshing()
//        }
    }
    
    var isRefreshing: Bool {
        return pullToRefreshView != nil && pullToRefreshView.state != .stopped
//        return self.mj_header != nil && self.mj_header.isRefreshing()
    }

    /// - Returns: 是否全部加载完成
    @discardableResult
    func adjustRefreshFooter(currentLoadedItemCount: Int) -> Bool {
        if currentLoadedItemCount >= Constants.pageLimit {
            self.mj_footer.resetNoMoreData()
            return true
        } else {
            self.mj_footer.endRefreshingWithNoMoreData()
            return false
        }
    }
}
