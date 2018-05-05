//
//  GoodsFeaturesSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

class GoodsFeaturesSectionItem: NormalDiffableItem {
    var data: GoodsFeaturesCellRequired
    
    init(data: GoodsFeaturesCellRequired) {
        self.data = data
        super.init()
    }
}


class GoodsFeaturesSectionController: ListSectionController {
    var object: GoodsFeaturesSectionItem?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return GoodsFeaturesCell.calculateSize(object?.data.content)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: GoodsFeaturesCell = collectionContext?.dequeueReusableCell(withNibName: GoodsFeaturesCell.reuseIdentifier, bundle: nil, for: self, at: index) as! GoodsFeaturesCell
        cell.model = object?.data
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? GoodsFeaturesSectionItem
    }
}
