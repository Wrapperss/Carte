//
//  CarteRefresh.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/2.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import MJRefresh

extension UICollectionView {
    
    
    func addPullToRefresh(_ block: @escaping () -> Void) {
        mj_header = MJRefreshNormalHeader(refreshingBlock: {
            block()
            self.mj_header.endRefreshing()
        })
    }
    
    func addLoadMore(_ block: @escaping () -> Void) {
        mj_footer = MJRefreshFooter(refreshingBlock: {
            block()
            self.mj_footer.endRefreshing()
        })
    }
}
