//
//  CartController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import IGListKit
import MJRefresh

class CartController: BaseListViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        source = DataFactory.sectionItem.prepareCommoditySectionItem()
        adapter.reloadData(completion: nil)
    }
    
    private func setupUI() {
        setNavigationBar()
        view.backgroundColor = .white
        
        adapter.dataSource = self
        
        collectionView.addPullToRefreshWithBlock {
            self.collectionView.endRefreshing()
        }
        
        collectionView.addLoadMoreRefreshWithBlock {
            self.collectionView.endRefreshing()
        }
    }
    
    func setNavigationBar()  {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(edit))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @objc private func edit() {
        
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


extension CartController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is CommoditySectionItem {
            return CommoditySectionController()
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
