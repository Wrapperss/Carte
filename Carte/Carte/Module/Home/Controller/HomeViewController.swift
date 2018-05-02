//
//  HomeViewController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/6.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import ReactorKit
import SnapKit
import IGListKit
import MJRefresh

class HomeViewController: BaseListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        adapter.dataSource = self
        
        collectionView.backgroundColor = UIColor.white
        
        source = [
            HeadlineSectionItem(HeadlineRequired(title: "今日推荐",
                                                 description: "全方位的生活指南，每天都有新乐趣",
                                                 type: HeadlineRequired.HeadlineType.instructions,
                                                 imageCount: 6)),
            CarouseSectionItem(CarouseCellRequired(data: [CarouseCompositionRequired(imageUrl: "https://pic4.zhimg.com/v2-78592608c30de9557bd454da2ab7cabb.jpg",
                                                                                     redTitle: "今日福利",
                                                                                     mediumTitle: "喜迎春节，超值闪购低至3折！",
                                                                                     grayTitle: "更多福利请进入活动页，一起HIGH起来吧！"),
                                                          CarouseCompositionRequired(imageUrl: "https://pic4.zhimg.com/v2-78592608c30de9557bd454da2ab7cabb.jpg",
                                                                                      redTitle: "今日福利",
                                                                                      mediumTitle: "喜迎春节，超值闪购低至3折！",
                                                                                      grayTitle: "更多福利请进入活动页，一起HIGH起来吧！"),
                                                          CarouseCompositionRequired(imageUrl: "https://pic4.zhimg.com/v2-78592608c30de9557bd454da2ab7cabb.jpg",
                                                                                      redTitle: "今日福利",
                                                                                      mediumTitle: "喜迎春节，超值闪购低至3折！",
                                                                                      grayTitle: "更多福利请进入活动页，一起HIGH起来吧！")]))]
        adapter.reloadData(completion: nil)
        
        collectionView.addPullToRefresh {
        }
        
        collectionView.addLoadMore {
            
        }
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is HeadlineSectionItem {
            return HeadlineSectionController()
        }
        if object is CarouseSectionItem {
            return CarouseSectionController()
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
