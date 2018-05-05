//
//  GoodsPostageSectionItem.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

class GoodsPostageSectionItem: NormalDiffableItem {
    var data: String
    
    init(data: String) {
        self.data = data
        super.init()
    }
}

class GoodsPostageSectionController: ListSectionController {
    var object: GoodsPostageSectionItem?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: 490)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: GoodsPostageCell = collectionContext?.dequeueReusableCell(withNibName: GoodsPostageCell.reuseIdentifier, bundle: nil, for: self, at: index) as! GoodsPostageCell
        cell.postageString = object?.data
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? GoodsPostageSectionItem
    }
}
