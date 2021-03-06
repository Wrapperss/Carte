//
//  CommodityContentSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/3.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

protocol CommodityContentSectionControllerDelegate: class {
    func didSelectCategory(_ category: CommoditySubItemCellRequired?)
}

class CommodityContentItem: NormalDiffableItem {
    var data: CommodityContentCellRequired
    
    init(_ data: CommodityContentCellRequired) {
        self.data = data
    }
}


class CommodityContentSectionController: ListSectionController {
    var object: CommodityContentItem?
    
    var delegate: CommodityContentSectionControllerDelegate
    
    init(delegate: CommodityContentSectionControllerDelegate) {
        self.delegate = delegate
         super.init()
    }
    
    override func numberOfItems() -> Int {
        return object?.data != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth / 5 * 3.5 - 5, height: 400)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: CommodityContentCell = collectionContext?.dequeueReusableCell(withNibName: CommodityContentCell.reuseIdentifier, bundle: nil, for: self, at: index) as! CommodityContentCell
        cell.model = object?.data
        cell.addSeparatorLine()
        cell.delegate = self
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? CommodityContentItem
    }
}

extension CommodityContentSectionController: CommodityContentCellDelegate {
    func didSelectCommodityContentCell(_ category: CommoditySubItemCellRequired?) {
        delegate.didSelectCategory(category)
    }
}
