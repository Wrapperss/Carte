//
//  MagazineController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/8.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

class MagazineController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.backgroundColor = .white
        return view
    }()
    
    var source = [MagazineCoverCellRequired]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        source = DataFactory.viewRequired.matchMagazineCoverCellRequired()
        tableView.reloadData()
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 300
        tableView.register(UINib(nibName: "MagazineCoverCell", bundle: nil),
                           forCellReuseIdentifier: "MagazineCoverCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
//        tableView.addPullToRefreshWithBlock {
//            self.tableView.endRefreshing()
//        }
//
//        tableView.addLoadMoreRefreshWithBlock {
//            self.tableView.endUpdates()
//        }
    }
}


extension MagazineController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MagazineCoverCell = tableView.dequeueReusableCell(withIdentifier: "MagazineCoverCell", for: indexPath) as! MagazineCoverCell
        cell.model = source[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
