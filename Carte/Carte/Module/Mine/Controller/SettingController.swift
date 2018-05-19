//
//  SettingController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit

class SettingController: UITableViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tableView.tableFooterView = UIView()
        title = "设置"
    }
}

extension SettingController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HUD.wait()
        Delay(time: 1.0) { [weak self] in
            self?.countLabel.text = "0.0M"
            HUD.showSuccess("清楚成功！")
        }
    }
}

