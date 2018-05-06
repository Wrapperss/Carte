//
//  AddressListController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/6.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Then
import SnapKit

class AddressListController: BaseViewController {
    
    let addButton = UIButton()
    let tableView = UITableView()
    var source = [AddressCellRequired]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        source.append(AddressCellRequired(name: "张力明", phone: "17826806391", address: "浙江省杭州市萧山区蜀山街道高桥路天香华庭10栋2单元2201石", isDefault: true))
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setNavigation()
        
        //tableView
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(AddressCell.self)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //addButton
        addButton.setTitle("+新地址", for: .normal)
        addButton.setTitleColor(UIColor(r: 252, g: 18, b: 36), for: .normal)
        addButton.backgroundColor = .white
        addButton.addTarget(self, action: #selector(addAddress), for: .touchUpInside)
        let line = SeparatorLine(position: SeparatorLine.Position.top, margin: (0,0), height: 0.5)
        line.work(with: addButton)
    }
    
    private func setNavigation() {
        title = "地址管理"
        navigationController?.navigationBar.isHidden = false
    }
    
    override func addConstraints() {
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addButton.snp.top)
        }
    }
    
    @objc
    private func addAddress() {
        navigationController?.pushViewController(AddAddressController.initFromStoryboard(name: .mine), animated: true)
    }
}

extension AddressListController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressCell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseIdentifier) as! AddressCell
        cell.model = source[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        source.remove(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
