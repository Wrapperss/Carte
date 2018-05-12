//
//  RegistViewController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/11.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

class RegistViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
        
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "注册", style: .done, target: self, action: #selector(regist))
        
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func comfirmAction(_ sender: Any) {
        
    }
    
    @IBAction func backItem(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func regist() {
        navigationController?.popViewController(animated: true)
    }
    
}
