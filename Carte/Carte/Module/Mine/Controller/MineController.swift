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
    
    @IBAction func button1Click(_ sender: Any) {
        let controller = OrderListRootController()
        controller.selectIndex = 1
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func button2Click(_ sender: Any) {
        let controller = OrderListRootController()
        controller.selectIndex = 2
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func button3Click(_ sender: Any) {
        let controller = OrderListRootController()
        controller.selectIndex = 3
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func button4Click(_ sender: Any) {
        let controller = OrderListRootController()
        controller.selectIndex = 4
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func button5Click(_ sender: Any) {
        let controller = OrderListRootController()
        controller.selectIndex = 5
        navigationController?.pushViewController(controller, animated: true)
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
            let alert = UIAlertController.init(title: "确定退出登陆？", message: nil, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "确定", style: .destructive) { [weak self] _ in
                Default.Account.set(0, forKey: .userId)
                let animation = {
                    let oldState = UIView.areAnimationsEnabled
                    UIView.setAnimationsEnabled(false)
                    UIApplication.shared.keyWindow?.rootViewController = LoginViewController.initFromStoryboard()
                    UIView.setAnimationsEnabled(oldState)
                }
                UIView.transition(with: self!.view,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: animation,
                                  completion: nil)
            }
            let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            alert.addAction(action)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
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

extension MineController {
    
}
