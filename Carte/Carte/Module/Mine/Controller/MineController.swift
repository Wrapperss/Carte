//
//  MineController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import Then
import ChameleonFramework
import SnapKit

class MineController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tableView.tableFooterView = UIView()
    }
    
}
