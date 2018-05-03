//
//  ClassifyController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

class ClassifyController: BaseListViewController {
    
    var titleSource = [SortTitleCellRequired]()
    
    fileprivate lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoUI()
        fetch()
    }
    
    func setuoUI() {
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib.init(nibName: "SortTitleCell", bundle: nil), forCellReuseIdentifier: "SortTitleCell")
        collectionView.backgroundColor = .white
    }
    
    
    override func addConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.screenWidth / 5 * 1.5)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(tableView.snp.trailing)
        }
    }
}

extension ClassifyController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SortTitleCell = tableView.dequeueReusableCell(withIdentifier: "SortTitleCell", for: indexPath) as! SortTitleCell
        cell.model = titleSource[indexPath.row]
        return cell
    }
}

extension ClassifyController {
    fileprivate func fetch() {
        HUD.wait()
        ClassifyAPI
            .fetchAllCategory()
            .always {
                HUD.clear()
            }
            .then { [weak self] (categorys) -> Void in
                self?.titleSource = DataFactory.viewRequired.matchSortTitleCellRequired(categorys)
                self?.tableView.reloadData()
                self?.tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.top)
            }
            .catch { (_) in
                HUD.showError("发生错误")
            }
    }
}
