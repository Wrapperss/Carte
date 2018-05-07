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
    
    let bottomView = CartBottomView.initFromNib()
    
    var cartSource = [CommoditySectionItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }
    
    private func setupUI() {
        setNavigationBar()
        view.backgroundColor = .white
        
        adapter.dataSource = self
    }
    
    func setNavigationBar()  {
        title = "购物车"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(edit))
    }
    
    
    @objc private func edit() {
        
    }
    
    override func addConstraints() {
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
    }
}


extension CartController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return cartSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is CommoditySectionItem {
            return CommoditySectionController(delegate: self)
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension CartController: CommoditySectionControllerDelegate {
    func deleteCartItem(_ cart: Cart) {
        var index = 0
        for i in 0 ..< source.count {
            if cartSource[i].data.id ?? 0 == cart.id ?? 0 {
                index = i
                break
            }
        }
        HUD.wait()
        CartAPI
            .removeCart(cart.id ?? 0)
            .always {
                HUD.clear()
            }
            .then { [weak self] (_) -> Void in
                self?.cartSource.remove(at: index)
                self?.adapter.performUpdates()
            }
            .catch { (_) in
            }
    }
}

extension CartController {
    fileprivate func fetch() {
        HUD.wait()
        CartAPI
            .fetchUserCart(userId: Default.Account.integer(forKey: .userId))
            .always {
                HUD.clear()
            }
            .then { [weak self] (carts) -> Void in
                self?.cartSource = DataFactory.sectionItem.prepareCommoditySectionItem(carts)
                self?.adapter.reloadData(completion: nil)
            }
            .catch { (_) in
                HUD.showError("发生错误")
            }
    }
}
