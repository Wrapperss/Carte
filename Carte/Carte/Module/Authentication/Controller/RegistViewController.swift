//
//  RegistViewController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/11.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import PromiseKit

class RegistViewController: UITableViewController {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
        
        navigationController?.navigationBar.isHidden = false
        
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func comfirmAction(_ sender: Any) {
        guard checkStringAvailable(usernameTextfield.text), checkStringAvailable(phoneTextfield.text), checkStringAvailable(passwordTextfield.text) else {
            HUD.showError("请填写完整信息")
            return
        }
        
        if PhoneNumberRule().validate(phoneTextfield.text!) {
            let user = User(balance: 0.0, createdAt: nil, email: nil, mobile: phoneTextfield.text!, password: passwordTextfield.text!, portrait: nil, token: nil, updatedAt: nil, name: usernameTextfield.text!)
            HUD.wait()
            AutherticationAPI
                .userRegist(user)
                .always {
                    HUD.clear()
                }
                .then { [weak self] (userId) -> Void in
                    Default.Account.set(userId, forKey: .userId)
                    self?.navigationController?.popViewController(animated: true)
                }
                .catch { (error) in
                    error.showHUD()
            }
        } else {
            HUD.showError("请输入正确格式的手机号")
        }
        
    }
    
    @IBAction func backItem(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
