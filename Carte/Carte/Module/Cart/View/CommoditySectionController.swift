//
//  CommoditySectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

protocol CommoditySectionControllerDelegate: class {
    func deleteCartItem(_ cart: Cart)
}

class CommoditySectionItem: NormalDiffableItem {
    let data: Cart
    
    init(data: Cart) {
        self.data = data
        super.init()
    }
}

class CommoditySectionController: ListSectionController {
    var object: CommoditySectionItem?

    var delegate: CommoditySectionControllerDelegate?
    
    init(delegate: CommoditySectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CommodityCell.size
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: CommodityCell = collectionContext?.dequeueReusableCell(withNibName: "CommodityCell", bundle: nil, for: self, at: index) as! CommodityCell
        guard let data = object?.data else {
            return cell
        }
        cell.cart = data
        cell.delegate = self
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? CommoditySectionItem
    }
}

extension CommoditySectionController: CommodityCellDelegate {
    func deleteCartItem(_ cart: Cart?) {
        guard let cart = cart else {
            return
        }
        delegate?.deleteCartItem(cart)
    }
}
