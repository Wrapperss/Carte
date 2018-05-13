//
//  HomeGoodsSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/13.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

protocol HomeGoodsSectionControllerDelegate: class {
    func didSelectHomeGoodsItem(_ categoryId: Int)
    func didSelectGoodsItem(_ goodsId: Int)
}

class HomeGoodsSectionItem: NormalDiffableItem {
    var requireds: [HomeGoodsCellRequired]
    var categoryId: Int
    
    init(requireds: [HomeGoodsCellRequired], categoryId: Int) {
        self.requireds = requireds
        self.categoryId = categoryId
    }
}


class HomeGoodsSectionController: ListSectionController {
    var object: HomeGoodsSectionItem?
    
    var delegate:HomeGoodsSectionControllerDelegate
    
    init(delegate: HomeGoodsSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
        inset = UIEdgeInsetsMake(10, 0, 0, 0)
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let title1 = object?.requireds.first?.title, let title2 = object?.requireds.last?.title else {
            return .zero
        }
        return CGSize(width: UIScreen.screenWidth,
                      height: HomeGoodsCell.calculateHeight(title1: title1,
                                                            title2: title2))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: HomeGoodsCell = collectionContext?.dequeueReusableCell(withNibName: HomeGoodsCell.reuseIdentifier, bundle: nil, for: self, at: index) as! HomeGoodsCell
        cell.model = object?.requireds
        cell.delegate = self
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let categoryId = object?.categoryId else {
            return
        }
        delegate.didSelectHomeGoodsItem(categoryId)
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? HomeGoodsSectionItem
    }
}

extension HomeGoodsSectionController: HomeGoodsCellDelegate {
    func didSelectGoodsItem(_ goodsId: Int) {
        delegate.didSelectGoodsItem(goodsId)
    }
}
