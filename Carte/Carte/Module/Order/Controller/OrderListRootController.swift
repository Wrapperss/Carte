//
//  OrderListRootController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit
import RxSwift
import WMPageController

class OrderListRootController: WMPageController {
    
    let titleSource = ["全部", "待付款", "待发货", "待收货", "待反馈", "退款"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dataSource = self
    }
    
    private func setupUI() {
        setupNavigaion()
        view.backgroundColor = .backgroundColor
        menuView?.backgroundColor = .white
    }
    
    private func setupNavigaion() {
        title = "订单"
        navigationController?.navigationBar.isHidden = false
    }
}

extension OrderListRootController {

    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return titleSource.count
    }

    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return titleSource[index]
    }

    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        return OrderListController(status: config(index))
    }

    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect(x: 0, y: 50, width: UIScreen.screenWidth, height: UIScreen.screenHeight - 50)
    }

    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 50)
    }
}


extension OrderListRootController {
    func config(_ index: Int) -> OrderListController.Status {
        if index == 0 {
            return OrderListController.Status.all
        } else if index == 1 {
            return OrderListController.Status.needToPay
        } else if index == 2 {
            return OrderListController.Status.needToDeliver
        } else if index == 3 {
            return OrderListController.Status.needToReceipt
        } else if index == 4 {
            return OrderListController.Status.needToFreeBack
        } else {
            return OrderListController.Status.needToRefund
        }
    }
}
