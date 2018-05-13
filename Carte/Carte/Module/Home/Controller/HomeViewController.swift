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
import MJRefresh

class HomeViewController: BaseListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetch()
    }
    
    private func setupUI() {
        adapter.dataSource = self
        collectionView.backgroundColor = .backgroundColor
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController {
    fileprivate func fetch() {
        HUD.wait()
        HomeAPI
            .fetchHome()
            .always {
                HUD.clear()
            }
            .then { [weak self] homeModel -> Void in
                guard let category = homeModel.category else {
                    return
                }
                self?.source = [DataFactory.sectionItem.prepareHomeCategoarySectionItem(category)]
                self?.adapter.reloadData(completion: nil)
            }
            .catch { (error) in
                error.showHUD()
            }
    }
}

extension HomeViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is HomeCategoarySectionItem {
            return HomeCategoarySectionController(delegate: self)
        }
        if object is HomeGoodsSectionItem {
            return HomeGoodsSectionController(delegate: self)
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension HomeViewController: HomeCategoarySectionControllerDelegate {
    func didSelectCategorySectionItem(_ category: Category) {
        let cate = CommoditySubItemCellRequired.init(categoryId: category.id ?? 0, cover: category.cover ?? "", title: category.name ?? "")
        navigationController?.pushViewController(GoodsListController(category: cate), animated: true)
    }   
}

extension HomeViewController: HomeGoodsSectionControllerDelegate {
    func didSelectHomeGoodsItem(_ categoryId: Int) {
        
        ClassifyAPI
            
        
        
        
        
        let controller = GoodsListController.init(category: CommoditySubItemCellRequired)
    }
}
