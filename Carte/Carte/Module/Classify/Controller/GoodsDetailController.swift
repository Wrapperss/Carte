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
    
    let banerView = GoodBanerView.initFromNib()
    
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
        collectionView.backgroundColor = UIColor.backgroundColor
        view.backgroundColor = .white
        adapter.dataSource = self
        
        banerView.delegate = self
    }
    
    private func setupNavigation() {
        title = "商品详情"
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
        
        view.addSubview(banerView)
        banerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(60)
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
        if object is GoodsInfoSectionItem {
            return GoodsInfoSectionController(delegate: self)
        }
        if object is GoodsFeaturesSectionItem {
            return GoodsFeaturesSectionController()
        }
        if object is GoodsPostageSectionItem {
            return GoodsPostageSectionController()
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension GoodsDetailController: GoodsInfoSectionControllerDelegate{
    func tapToMoreInfo() {
        navigationController?.pushViewController(MoreInfoController.init(goodsId: goodsId), animated: true)
    }
}

extension GoodsDetailController: GoodBanerViewDelegate {
    func toCart() {
        
    }
    
    func addCart() {
        
    }
    
    func toBuy() {
        
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
