//
//  HomeViewController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/6.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import ReactorKit
import SnapKit
import IGListKit

class HomeViewController: BaseListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setup() {
        adapter.delegate = self
        adapter.dataSource = self
    }
    
}


extension HomeViewController: ListAdapterDataSource, IGListAdapterDelegate {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay object: Any, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying object: Any, at index: Int) {
        
    }
}
