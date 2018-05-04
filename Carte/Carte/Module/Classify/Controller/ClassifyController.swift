//
//  ClassifyController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

class ClassifyController: BaseListViewController {
    
    fileprivate var titleSource = [SortTitleCellRequired]()
    fileprivate var contentSource = [CommodityContentItem]()
    
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
    
    private func setuoUI() {
        setupNavigation()
        
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor(r: 244, g: 244, b: 244)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib.init(nibName: "SortTitleCell", bundle: nil), forCellReuseIdentifier: "SortTitleCell")
        
        
        collectionView.backgroundColor = .white
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
    
    private func setupNavigation() {
        let item = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(toSearch))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc
    func toSearch() {
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collectionView.contentOffset = CGPoint(x: 0, y: indexPath.row * 400)
    }
}

extension ClassifyController: ListAdapterDataSource, UIScrollViewDelegate {
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return contentSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return CommodityContentSectionController()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let row =  Int((scrollView.contentOffset.y + 200) / 400)
        tableView.selectRow(at: IndexPath.init(row: row, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle )
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
                self?.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.top)
                
                let superCateGory = categorys.filter { $0.superCategory == nil }
                self?.contentSource = superCateGory
                                            .map { DataFactory.viewRequired.matchCommodityCellRequired(mainCategory: $0, allCategory: categorys) }
                                            .map { DataFactory.sectionItem.prapareCommodityContentItem($0) }
                self?.adapter.reloadData(completion: nil)
            }
            .catch { (_) in
                HUD.showError("发生错误")
            }
    }
}
