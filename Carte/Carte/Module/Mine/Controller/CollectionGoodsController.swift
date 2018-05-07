//
//  CollectionGoodsController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/7.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import PromiseKit
import RxSwift
import IGListKit
import SnapKit


class CollectionGoodsController: BaseListViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        title = "喜欢的商品"
        
        adapter.dataSource = self
        collectionView.addPullToRefresh {
            self.fetch()
        }
        
        collectionView.addLoadMore {
        }
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension CollectionGoodsController {
    fileprivate func fetch() {
        HUD.wait()
        CollectionAPI
            .fetchCollectGoods(userId: Default.Account.integer(forKey: .userId))
            .always {
                HUD.clear()
            }
            .then { [weak self] (goodses) -> Void in
                self?.source = DataFactory.sectionItem.prepareGoodsItem(DataFactory.viewRequired.matchGoodsCellRequired(goodses))
                self?.adapter.reloadData(completion: nil)
            }
            .catch { (_) in
                HUD.showError("发生错误")
        }
    }
}

extension CollectionGoodsController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return GoodsSectionController(delegate: self)
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}


extension CollectionGoodsController: GoodsSectionControllerDelegate {
    func selectGoodsItem(_ id: Int) {
        navigationController?.pushViewController(GoodsDetailController(goodsId: id), animated: true)
    }
}
