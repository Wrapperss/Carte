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
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
//        button1.setButtonVerticalStyle(imageName: "waitForPay", title: "待付款")
//        button2.setButtonVerticalStyle(imageName: "fahuo", title: "待发货")
//        button3.setButtonVerticalStyle(imageName: "shouhuo", title: "待收货")
//        button4.setButtonVerticalStyle(imageName: "fankui", title: "待反馈")
//        button5.setButtonVerticalStyle(imageName: "tuikuan", title: "退款")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension MineController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            self.present(MainNavigationController(rootViewController: LoginViewController.initFromStoryboard()),
                         animated: true,
                         completion: nil)
        }
    }
    

}
