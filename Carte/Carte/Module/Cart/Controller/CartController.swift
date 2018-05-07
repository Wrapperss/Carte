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
    
    var currentState = CartBottomView.State.buy
    
    var allCart = [Cart]()
    var selectCart = [Cart]()
    
    var totalPrice: Double = 0 {
        didSet {
            if totalPrice <= 0 {
                totalPrice = 0
            }
            bottomView.allCountLabel.text = "合计：\(totalPrice)元"
        }
    }
    
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
        bottomView.delegate = self
    }
    
    func setNavigationBar()  {
        title = "购物车"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(edit))
    }
    
    
    @objc private func edit() {
        switch currentState {
        case .edit:
            currentState = CartBottomView.State.buy
            navigationItem.rightBarButtonItem?.title = "编辑"
        case .buy:
            currentState = CartBottomView.State.edit
            navigationItem.rightBarButtonItem?.title = "完成"
        }
        bottomView.currentState = currentState
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
    func changeCart(cart: Cart, goods: Goods) {
        let selected = selectCart.filter { $0.id ?? 0 == cart.id }.first
        
        guard let select = selected, let price = goods.price else {
            return
        }
        totalPrice = totalPrice - Double(select.quantity ?? 0) * price + Double(cart.quantity ?? 0) * price
        
        var index = 0
        for i in 0 ..< selectCart.count {
            if selectCart[i].id == select.id {
                index = i
            }
        }
        selectCart[index] = cart
    }
    
    func didSelectCartItem(_ cart: Cart) {
        navigationController?.pushViewController(GoodsDetailController(goodsId: cart.goodsId ?? 0), animated: true)
    }
    
    func itemChange(isOn: Bool, cart: Cart, goods: Goods) {
        let cost = (goods.price ?? 0.0) * (Double(cart.quantity ?? 0))
        if isOn {
            totalPrice = totalPrice + cost
            selectCart.append(cart)
            if selectCart.count == allCart.count {
                bottomView.checkButton.on = true
            }
        } else {
            totalPrice = totalPrice - cost
            selectCart = selectCart.filter { $0.id ?? 0 != cart.id ?? 0 }
            if selectCart.count == 0 {
                bottomView.checkButton.on = false
            }
        }
    }
    
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

extension CartController: CartBottomViewDelegate {
    func redButtonTap() {
        switch currentState {
        case .edit:
            for select in selectCart {
                var index = 0
                for i in 0 ..< cartSource.count {
                    if cartSource[i].data.id ?? 0 == select.id {
                        index = i
                        CartAPI
                            .removeCart(select.id ?? 0)
                            .then { [weak self] (_) -> Void in
                                self?.cartSource.remove(at: index)
                                self?.adapter.performUpdates(animated: true, completion: nil)
                            }
                            .catch { (_) in
                            }
                        break
                    }
                }
            }
            bottomView.checkButton.on = false
            bottomView.allCountLabel.text = "合计：0元"
        case .buy:
            break
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
                self?.allCart = carts
                self?.cartSource = DataFactory.sectionItem.prepareCommoditySectionItem(carts)
                self?.adapter.reloadData(completion: nil)
            }
            .catch { (_) in
                HUD.showError("发生错误")
            }
    }
}
