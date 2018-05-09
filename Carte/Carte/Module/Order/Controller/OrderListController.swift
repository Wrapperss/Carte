//
//  OrderListController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit
import WMPageController
import PromiseKit
import SnapKit


class OrderListController: BaseListViewController {
    
    enum Status {
        case all
        case needToPay
        case needToDeliver
        case needToReceipt
        case needToFreeBack
        case needToRefund
    }
    
    var status: Status
    
    var orderContents: [OrderContent]? {
        didSet {
            guard let orderContents = orderContents else {
                return
            }
            source = orderContents.flatMap { DataFactory.sectionItem.prepareOrderListCell($0) }
            adapter.reloadData(completion: nil)
        }
    }
    
    init(status: Status) {
        self.status = status
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
        view.backgroundColor = .backgroundColor
        adapter.dataSource = self
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension OrderListController {
    fileprivate func fetch() {
        OrderAPI
            .fetchUserOrder(Default.Account.integer(forKey: .userId))
            .then { [weak self] orderContents -> Void in
                self?.orderContents = orderContents
            }
            .catch { (_) in
                HUD.showError("发生错误")
            }
    }
}


extension OrderListController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is OrderSectionItem {
            return OrderSectionController(delegate: self)
        } else if object is FormItem {
            return FormSectionController()
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension OrderListController: OrderSectionControllerDelegate {
    func didSelectGoodsItem(_ id: Int) {
        navigationController?.pushViewController(GoodsDetailController(goodsId: id), animated: true)
    }
}
