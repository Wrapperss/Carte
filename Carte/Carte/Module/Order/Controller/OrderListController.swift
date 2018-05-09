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
    }
    
}

extension OrderListController {
    fileprivate func fetch() {
        OrderAPI
            .fetchUserOrder(Default.Account.integer(forKey: .userId))
            .then { orderContents -> Void in
                
            }
            .catch { (_) in
                
            }
    }
}



