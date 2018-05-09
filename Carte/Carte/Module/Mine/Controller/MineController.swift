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
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        fetch()
    }
    
}

extension MineController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 { // 个人信息
            
        } else if indexPath.row == 1 { //我的订单
            navigationController?.pushViewController(OrderListRootController(), animated: true)
        } else if indexPath.row == 2 { //订单分类
            
        } else if indexPath.row == 3 { //我喜欢的商品
            navigationController?.pushViewController(CollectionGoodsController(), animated: true)
        } else if indexPath.row == 4 { //我的地址
            navigationController?.pushViewController(AddressListController(), animated: true)
        } else if indexPath.row == 6 { //设置
            
        } else if indexPath.row == 7 { //用户协议
            
        } else if indexPath.row == 8 { //联系我们
            
        }
    }
}

extension MineController {
    fileprivate func fetch() {
        HUD.wait()
        MineAPI
            .fetchUserInfo(Default.Account.integer(forKey: .userId))
            .always {
                HUD.clear()
            }
            .then { [weak self] (user) -> Void in
                self?.nameLabel.text = user.name ?? "-"
            }
            .catch { (error) in
                HUD.showInfo("获取用户信息失败")
        }
    }
}
