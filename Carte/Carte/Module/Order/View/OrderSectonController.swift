//
//  OrderSectonController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

protocol OrderSectionControllerDelegate: class {
    func didSelectGoodsItem(_ id: Int)
}

class OrderSectionItem: NormalDiffableItem {
    var data: OrderContent.OrderGoods
    
    init(data: OrderContent.OrderGoods) {
        self.data = data
        super.init()
    }
}


class OrderSectionController: ListSectionController {
    
    var object: OrderSectionItem?
    
    var delegate: OrderSectionControllerDelegate
    
    init(delegate: OrderSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: OrderCell = collectionContext?.dequeueReusableCell(withNibName: OrderCell.reuseIdentifier, bundle: nil, for: self, at: index) as! OrderCell
        cell.orderGoods = object?.data
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let goodsId = object?.data.goodsId else {
            return
        }
        delegate.didSelectGoodsItem(goodsId)
    }
}

