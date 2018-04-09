//
//  ClassifyController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

class ClassifyController: BaseListViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = UIColor(224, 224, 224, 1)
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoUI()
    }
    
    func setuoUI() {
        view.backgroundColor = .white
        
        
        collectionView.backgroundColor = .white
    }
    
    
    override func addConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.screenWidth / 5 * 1.3)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(tableView.snp.trailing)
        }
    }
}
