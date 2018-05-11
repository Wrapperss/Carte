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
        
        func confit(text: String) -> Bool {
            switch self {
            case .all:
                return true
            case .needToPay:
                return text == "待付款"
            case .needToDeliver:
                return text == "待发货"
            case .needToReceipt:
                return text == "待收货"
            case .needToFreeBack:
                return text == "待反馈"
            case .needToRefund:
                return text == "退款"
            }
        }
    }
    
    var status: Status
    
    var orderContents: [OrderContent]? {
        didSet {
            guard let orderContents = orderContents else {
                return
            }
            source = orderContents.flatMap { DataFactory.sectionItem.prepareOrderListCell($0, status: status) }
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                self?.orderContents = orderContents.filter { (self?.status ?? .all).confit(text: $0.order?.status ?? "") }
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
            return FormSectionController(delegate: self, inset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension OrderListController: FormSectionControllerDelegate {
    func didSelectForm(item: FormItemProtocol, in sectionController: FormSectionController) {
        if item is OrderContentFormItem {
            let orderContentFormItem = item as! OrderContentFormItem
            guard let order = orderContentFormItem.orderContent?.order else {
                return
            }
            switch order.status ?? "" {
            case "待付款":
                let controller = PayForGoodsController.initFromStoryboard(name: .classify)
                controller.order = order
                controller.singleBack = true
                navigationController?.pushViewController(controller, animated: true)
            case "待收货":
                let alert = UIAlertController.init(title: "确认已经收到商品？", message: "确认后将不能进行修改！", preferredStyle: .alert)
                let confirmAction = UIAlertAction.init(title: "确定", style: .default) { (_) in
                    HUD.wait()
                    var newOrder = order
                    newOrder.status = "待反馈"
                    OrderAPI
                        .updateOrder(orderId: order.id ?? 0, order: newOrder)
                        .always {
                            HUD.clear()
                        }
                        .then(execute: { [weak self] (_) -> Void in
                            HUD.showSuccess("确认收货成功")
                            Delay(time: 1.0, task: {
                                self?.fetch()
                            })
                        })
                        .catch(execute: { (error) in
                            error.showHUD()
                        })
                }
                let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
                alert.addAction(confirmAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            default:
                break
            }
        }
    }
}


extension OrderListController: OrderSectionControllerDelegate {
    func didSelectGoodsItem(_ id: Int) {
        navigationController?.pushViewController(GoodsDetailController(goodsId: id), animated: true)
    }
}
