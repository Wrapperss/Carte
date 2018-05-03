//
//  RechargeController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/3.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation

class RechargeController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var userInfo: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }
    
    private func setNavigation() {
        title = "零钱充值"
        let backItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backItem
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func back() {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func rechangeTap(_ sender: Any) {
        if !checkStringAvailable(textField.text) {
            HUD.showError("请输入充值金额！")
        } else {
            post()
        }
    }
}

extension RechargeController {
    fileprivate func fetch() {
        HUD.wait()
        MineAPI
            .fetchUserInfo(Default.Account.integer(forKey: .userId))
            .always {
                HUD.clear()
            }
            .then { [weak self] (user) -> Void in
                self?.userInfo = user
            }
            .catch { (error) in
                HUD.showInfo("获取用户信息失败")
        }
    }
    
    fileprivate func post() {
        if userInfo != nil {
            let balance = Double(textField.text ?? "0") ?? 0
            let oldBlance = userInfo?.balance ?? 0
            userInfo?.balance = oldBlance + balance
            HUD.wait()
            MineAPI
                .updateUserInfo(userInfo!)
                .always {
                    HUD.clear()
                }
                .then { [weak self] (_) -> Void in
                    HUD.showSuccess("充值成功！")
                    Delay(time: 1.0, task: {
                        self?.dismiss(animated: true, completion: nil)
                    })
                }
                .catch { (_) in
                    HUD.showError("发生错误！")
            }
        } else {
            HUD.showError("发生错误！")
        }
    }
}
