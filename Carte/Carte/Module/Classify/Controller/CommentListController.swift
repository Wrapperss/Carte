//
//  CommentListController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit
import RxSwift
import SnapKit

class CommentListController: BaseListViewController {
    
    let comments: [Comment]
    
    init(comments: [Comment]) {
        self.comments = comments
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        config()
    }
    
    private func setupUI() {
        title = "评论"
        
        adapter.dataSource = self
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func config() {
        source = comments.map { DataFactory.sectionItem.prepareGoodsCommentItem($0) }
        adapter.reloadData(completion: nil)
    }
}

extension CommentListController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is GoodsCommentCoverSectionItem {
            return GoodsCommentCoverSectionController()
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无评论")
    }
}
