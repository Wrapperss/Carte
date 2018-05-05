//
//  GoodsDetailController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import SnapKit
import IGListKit

class GoodsDetailController: BaseListViewController {
    
    var goodsId: Int
    
    init(goodsId: Int) {
        self.goodsId = goodsId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetch()
    }
    
    private func setupUI() {
        setupNavigation()
        view.backgroundColor = UIColor.backgroundColor
        
        adapter.dataSource = self
    }
    
    private func setupNavigation() {
        title = "商品详情"
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


extension GoodsDetailController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is GoodsHeaderSectionItem {
            return GoodsHeaderSectionController()
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension GoodsDetailController {
    fileprivate func fetch() {
        HUD.wait()
        ClassifyAPI
            .fetchGoodsDetail(goodsId)
            .always {
                HUD.clear()
            }
            .then { [weak self] (goods) -> Void in
                self?.source = DataFactory.sectionItem.prepareGoodsDetailItem(goods)
                self?.adapter.reloadData(completion: nil)
            }
            .catch { (_) in
                HUD.showError("发送错误")
        }
    }
}
