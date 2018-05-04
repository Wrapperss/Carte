//
//  GoodsSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/4.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

class GoodsSectionItem: NormalDiffableItem {
    var data: GoodsCellRequired
    
    init(data: GoodsCellRequired) {
        self.data = data
        super.init()
    }
}

class GoodsSectionController: ListSectionController {
    
    var object: GoodsSectionItem?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth - 20, height: 120)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: GoodsCell = collectionContext?.dequeueReusableCell(withNibName: GoodsCell.reuseIdentifier, bundle: nil, for: self, at: index) as! GoodsCell
        
        cell.model = object?.data
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? GoodsSectionItem
    }
}
