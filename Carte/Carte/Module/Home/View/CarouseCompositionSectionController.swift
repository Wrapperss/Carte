//
//  CarouseCompositionSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import IGListKit

class CarouseCompositionSectionItem: NormalDiffableItem {
    var data: [CarouseCompositionRequired]
    
    init(data: [CarouseCompositionRequired]) {
        self.data = data
    }
}

class CarouseCompositionSectionController: ListSectionController {
    
    var object: CarouseCompositionSectionItem?
    
    override func numberOfItems() -> Int {
        return object?.data.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CarouseCompositionCell.size
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: CarouseCompositionCell = collectionContext?.dequeueReusableCell(of: CarouseCompositionCell.self, for: self, at: index) as! CarouseCompositionCell
        cell.config((object?.data[index]))
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? CarouseCompositionSectionItem
    }
}
