//
//  ConfirmOrderController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit
import RxSwift
import SnapKit

class ConfirmOrderController: BaseListViewController {
    
    let bottomView = OrderBottomView.initFromNib()
    let cartMsg: [(cart: Cart, goods: Goods)]
    
    init(cartMsg: [(cart: Cart, goods: Goods)]) {
        self.cartMsg = cartMsg
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
        title = "确认订单"
        view.backgroundColor = .white
        bottomView.delegate = self
        adapter.dataSource = self
        
        var allCoust: Double = 0.0
        for msg in cartMsg {
            allCoust = allCoust + Double(msg.cart.quantity ?? 0) * (msg.goods.price ?? 0.0)
        }
        bottomView.countLabel.text = "合计：\(allCoust)元"
    }
    
    override func addConstraints() {
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(60)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
    }
}

extension ConfirmOrderController {
    fileprivate func fetch() {
        HUD.wait()
        AddressAPI
            .fetchUserAddress(userId: Default.Account.integer(forKey: .userId))
            .always {
                HUD.clear()
            }
            .then { [weak self] addresses -> Void in
                let defaultAddress = addresses.filter { $0.isDefault ?? 0 == 1 }
                if defaultAddress.count > 0 {
                    self?.source = DataFactory.sectionItem.prepareOrderConfirmSoure(address: defaultAddress.first!, cartMsg: (self?.cartMsg)!)
                    self?.adapter.reloadData(completion: nil)
                } else {
                    
                }
                
            }
            .catch { (_) in
                HUD.showError("发生错误")
            }
    }
}

extension ConfirmOrderController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is OrderAdressSectionItem {
            return OrderAdressSectionController(delegate: self)
        }
        return FormSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension ConfirmOrderController: OrderAdressSectionControllerDelegate {
    func didSelectOrderAddressItem() {
        navigationController?.pushViewController(AddressListController(), animated: true)
    }
}

extension ConfirmOrderController: OrderBottomViewDelegate {
    func payButtonTap() {
        
    }
}
