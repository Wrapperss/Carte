//
//  UserInfoController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/2.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit
import PromiseKit
import RxSwift

class UserInfoController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var blanceLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }
}


extension UserInfoController {
    
    fileprivate func fetch() {
        HUD.wait()
        MineAPI
            .fetchUserInfo(Default.Account.integer(forKey: .userId))
            .always {
                HUD.clear()
            }
            .then { [weak self] (user) -> Void in
                self?.setUserInfo(user)
            }
            .catch { (error) in
                HUD.showInfo("获取用户信息失败")
        }
    }
    
    fileprivate func setUserInfo(_ user: User) {
        self.user = user
        nameLabel.text = user.name ?? ""
        emailLabel.text = user.email ?? ""
        blanceLabel.text = "¥\(user.balance ?? 0.00)"
        mobileLabel.text = user.mobile ?? ""
        passwordLabel.text = "******"
    }
}

extension UserInfoController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let controlelr = ModifyUserInfoController.initFromStoryboard(name: .mine)
            controlelr.userInfo = user
            if indexPath.row == 0 {
                present(MainNavigationController(rootViewController: controlelr), animated: true, completion: { controlelr.type = ModifyUserInfoController.UserInfoType.name })
            } else if indexPath.row == 1 {
                present(MainNavigationController(rootViewController: controlelr), animated: true, completion: { controlelr.type = ModifyUserInfoController.UserInfoType.email })
            }
        }
    }
}
