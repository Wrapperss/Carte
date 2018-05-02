//
//  ModifyUserInfoController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/2.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import PromiseKit

class ModifyUserInfoController: UIViewController {
    
    enum UserInfoType {
        case name
        case email
    }
    
    var userInfo: User?
    var type: UserInfoType? {
        didSet {
            config(type)
        }
    }
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        let leftItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc
    func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func save() {
        if checkStringAvailable(textField.text) {
            switch type ?? .name {
            case .name:
                userInfo?.name = textField.text
            case .email:
                userInfo?.email = textField.text
            }
            post()
        } else {
            HUD.showError("内容不能为空！")
        }
    }
    
    private func config(_ type: UserInfoType?) {
        guard let type = type, let user = userInfo else {
            return
        }
        
        switch type {
        case .name:
            title = "设置昵称"
            textField.placeholder = "请输入昵称"
            textField.text = user.name ?? "-"
        case .email:
            title =  "设置邮箱"
            textField.placeholder = "请输入邮箱"
            textField.text = user.email ?? "-"
        }
    }
}

extension ModifyUserInfoController {
    fileprivate func post() {
        guard let userInfo = userInfo else {
            HUD.showError("发生错误！")
            return
        }
        HUD.wait()
        MineAPI
            .updateUserInfo(userInfo)
            .always {
                HUD.clear()
            }
            .then { [weak self] (_) -> Void in
                self?.dismiss(animated: true, completion: nil)
            }
            .catch { (_) in
                HUD.showError("修改发生错误！")
            }
    }
}
