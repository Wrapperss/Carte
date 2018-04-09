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
        
    }
    
    @IBAction func dismissButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
