//
//  CommoditySectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

class CommoditySectionItem: NormalDiffableItem {
    let data: CommodityCellRequired
    
    init(data: CommodityCellRequired) {
        self.data = data
        super.init()
    }
}


class CommoditySectionController: ListSectionController {
    var object: CommoditySectionItem?

    override func numberOfItems() -> Int {
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CommodityCell.size
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: CommodityCell = collectionContext!.dequeue(withNibType: CommodityCell.self, for: self, at: index)
        
        guard let data = object?.data else {
            return cell
        }
        cell.model = data
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? CommoditySectionItem
    }
}
