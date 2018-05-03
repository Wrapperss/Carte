//
//  BlanceController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/3.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation

class BlanceController: UIViewController {
    
    @IBOutlet weak var blanceLabel: UILabel!
    @IBOutlet weak var rechargeButton: UIButton!
    @IBOutlet weak var withdrawButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "零钱"
        rechargeButton.cornerRadius = 5
        withdrawButton.cornerRadius = 5
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }
    
    @IBAction func rechargeButtonTap(_ sender: Any) {
        let controller = RechargeController.initFromStoryboard(name: .mine)
        present(MainNavigationController.init(rootViewController: controller), animated: true, completion: nil)
    }
}

extension BlanceController {
    fileprivate func fetch() {
        HUD.wait()
        MineAPI
            .fetchUserInfo(Default.Account.integer(forKey: .userId))
            .always {
                HUD.clear()
            }
            .then { [weak self] (user) -> Void in
                self?.blanceLabel.text = "¥\(user.balance ?? 0.00)"
            }
            .catch { (error) in
                HUD.showInfo("获取用户信息失败")
        }
    }
}
