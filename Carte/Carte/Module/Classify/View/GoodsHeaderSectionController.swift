//
//  GoodsHeaderSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

class GoodsHeaderSectionItem: NormalDiffableItem {
    var data: GoodsHeaderCellRequired
    
    init(data: GoodsHeaderCellRequired) {
        self.data = data
        super.init()
    }
}


class GoodsHeaderSectionController: ListSectionController {
    var object: GoodsHeaderSectionItem?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: 420)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: GoodsHeaderCell = collectionContext?.dequeueReusableCell(withNibName: GoodsHeaderCell.reuseIdentifier, bundle: nil, for: self, at: index) as! GoodsHeaderCell
        
        cell.model = object?.data
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? GoodsHeaderSectionItem
    }
}
