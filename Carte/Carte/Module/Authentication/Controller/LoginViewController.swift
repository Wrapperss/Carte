//
//  LoginViewController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/8.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import PasswordTextField

class LoginViewController: UIViewController {
 
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var accoutTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        confirmButton.cornerRadius = 4
    }
    @IBAction func confirmButtonClick(_ sender: Any) {
        guard checkStringAvailable(accoutTextField.text), checkStringAvailable(passwordTextField.text) else {
            HUD.showInfo("请输入完整信息")
            return
        }
        HUD.wait()
        AutherticationAPI
            .userLogin(mobile: accoutTextField.text ?? "", password: passwordTextField.text ?? "")
            .always {
                HUD.clear()
            }
            .then { [weak self] user -> Void in
                Default.Account.set(user.id ?? 0, forKey: .userId)
                let animation = {
                    let oldState = UIView.areAnimationsEnabled
                    UIView.setAnimationsEnabled(false)
                    UIApplication.shared.keyWindow?.rootViewController = MainTabBarController()
                    UIView.setAnimationsEnabled(oldState)
                }
                UIView.transition(with: self!.view,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: animation,
                                  completion: nil)
            }
            .catch { (error) in
                HUD.showError("登陆失败")
            }
    }
    
    @IBAction func dismissButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonClick(_ sender: Any) {
        navigationController?.pushViewController(RegistViewController.initFromStoryboard(), animated: true)
    }
}
