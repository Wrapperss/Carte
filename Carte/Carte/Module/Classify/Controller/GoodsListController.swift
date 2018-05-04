//
//  GoodsListController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/4.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import PromiseKit
import RxSwift
import SnapKit

class GoodsListController: BaseListViewController {
    let category: CommoditySubItemCellRequired
    
    let topView = TopSelectView.initFromNib()
    
    init(category: CommoditySubItemCellRequired) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = category.title
        topView.setInitialIndex()
        topView.delegate = self
    }
    
    override func addConstraints() {
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}


extension GoodsListController {
    fileprivate func fetch() {
        HUD.wait()
        ClassifyAPI
            .fetchGoodsInCategory(category.categoryId)
            .always {
                    HUD.clear()
            }
            .then { goods in
                print(goods)
            }
            .catch { _ in
                HUD.showError("发送错误")
            }
    }
}

extension GoodsListController: TopSelectViewDelegate {
    func selectItem(_ index: Int) {
        
        
    }
}

