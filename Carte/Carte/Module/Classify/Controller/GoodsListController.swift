//
//  GoodsListController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/4.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import PromiseKit
import RxSwift
import IGListKit
import SnapKit

class GoodsListController: BaseListViewController {

    let category: CommoditySubItemCellRequired
    
    let topView = TopSelectView.initFromNib()
    
    var currentSelect = TopSelectView.SelectType.defaultSelect
    
    init(category: CommoditySubItemCellRequired) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = category.title
        topView.setInitialIndex()
        topView.delegate = self
        
        adapter.dataSource = self
        collectionView.addPullToRefresh {
            self.fetch()
        }
        
        collectionView.addLoadMore {
            
        }
    }
    
    override func addConstraints() {
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


extension GoodsListController {
    fileprivate func fetch() {
        HUD.wait()
        
        switch currentSelect {
        case .defaultSelect:
            ClassifyAPI
                .fetchGoodsInCategory(category.categoryId)
//                .fetchGoodsInCategory(1)
                .always {
                    HUD.clear()
                }
                .then { [weak self] goods -> Void in
                    self?.source = DataFactory.sectionItem.prepareGoodsItem(DataFactory.viewRequired.matchGoodsCellRequired(goods))
                    self?.adapter.reloadData(completion: nil)
                }
                .catch { _ in
                    HUD.showError("发送错误")
            }
        case .sales:
            ClassifyAPI
                .fetchGoodsInCategoryByVolume(category.categoryId)
//                .fetchGoodsInCategoryByVolume(1)
                .always {
                    HUD.clear()
                }
                .then { [weak self] goods -> Void in
                    self?.source = DataFactory.sectionItem.prepareGoodsItem(DataFactory.viewRequired.matchGoodsCellRequired(goods))
                    self?.adapter.reloadData(completion: nil)
                }
                .catch { _ in
                    HUD.showError("发送错误")
            }
        case .price:
            ClassifyAPI
                .fetchGoodsInCategoryByPrice(category.categoryId)
//                .fetchGoodsInCategoryByPrice(1)
                .always {
                    HUD.clear()
                }
                .then { [weak self] goods -> Void in
                    self?.source = DataFactory.sectionItem.prepareGoodsItem(DataFactory.viewRequired.matchGoodsCellRequired(goods))
                    self?.adapter.reloadData(completion: nil)
                }
                .catch { _ in
                    HUD.showError("发送错误")
            }
        }
    }
}

extension GoodsListController: ListAdapterDataSource {
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

extension GoodsListController: TopSelectViewDelegate {
    func selectItem(_ type: TopSelectView.SelectType) {
        currentSelect = type
        fetch()
    }
}

extension GoodsListController: GoodsSectionControllerDelegate {
    func selectGoodsItem(_ id: Int) {
        navigationController?.pushViewController(GoodsDetailController(goodsId: id), animated: true)
    }
}
