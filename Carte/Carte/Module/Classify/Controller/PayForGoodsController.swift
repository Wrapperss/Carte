//
//  PayForGoodsController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

class PayForGoodsController: UIViewController {
    
    @IBOutlet weak var allCostLabel: UILabel!
    
    var order: OrderContent.Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let order = order else {
            allCostLabel.text = "待支付-元"
            return
        }
        
        allCostLabel.text = "待支付\(order.payment ?? 0.0)元"
    }
    
    private func setupUI() {
        title = "支付订单"
    }
    
    @IBAction func payAction(_ sender: Any) {
        HUD.wait()
        Delay(time: 1.0) { [weak self] in
            guard let order = self?.order else {
                HUD.showError("支付失败")
                return
            }
            OrderAPI
                .putPayForTheOrder(userId: Default.Account.integer(forKey: .userId), orderId: order.id ?? 0)
                .then(execute: { (_) -> Void in
                    HUD.showSuccess("支付成功")
                    Delay(time: 1.0, task: { [weak self] in
                        self?.navigationController?.popToRootViewController(animated: true)
                    })
                })
                .catch(execute: { (errpr) in
                    errpr.showHUD()
                })
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
