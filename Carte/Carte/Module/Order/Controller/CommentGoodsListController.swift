//
//  CommentGoodsListController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/11.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit
import SnapKit

class CommentGoodsListController: BaseListViewController {
    
    let orderContent: OrderContent
    
    var commentGoodsIds = [Int]()
    
    init(orderContent: OrderContent) {
        self.orderContent = orderContent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.registerNotification(self, #selector(addComment(notification:)), name: .allReadyComment)
        guard let orderGoods = orderContent.orderGoods else {
            return
        }

        source = orderGoods.map { OrderSectionItem(data: $0) }
        adapter.reloadData(completion: nil)
    }
    
    deinit {
        NotificationCenter.remove(self)
    }
    
    private func setupUI() {
        title = "购物清单"
        view.backgroundColor = .white
        adapter.dataSource = self
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc
    private func addComment(notification: Notification) {
        let id = notification.userInfo!["goodsId"] as! Int
        for goodsId in commentGoodsIds {
            if goodsId == id {
                return
            }
        }
        commentGoodsIds.append(id)
        if commentGoodsIds.count == orderContent.orderGoods?.count {
            guard let order = orderContent.order else {
                return
            }
            var newOrder = order
            newOrder.status = "完成"
            OrderAPI
                .updateOrder(orderId: orderContent.order?.id ?? 0, order: newOrder)
                .then { (_) -> Void in
                }
                .catch { (_) in
                }
        }
    }
}

extension CommentGoodsListController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is OrderSectionItem {
            return OrderSectionController(delegate: self)
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension CommentGoodsListController: OrderSectionControllerDelegate {
    func didSelectGoodsItem(_ id: Int) {
        for goodsId in commentGoodsIds {
            if goodsId == id {
                HUD.showInfo("已经反馈过啦")
                return
            }
        }
        let controller = AddCommentController.init(goodsId: id)
        navigationController?.pushViewController(controller, animated: true)
    }
}


