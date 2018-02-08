//
//  CarouseSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/8.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

class CarouseSectionItem: NormalDiffableItem {
    let data: CarouseCellRequired
    
    init(_ data: CarouseCellRequired) {
        self.data = data
    }
}


class CarouseSectionController: ListSectionController {
    var object: CarouseSectionItem?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: CarouseCell.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: CarouseCell = collectionContext?.dequeueReusableCell(of: CarouseCell.self, for: self, at: index) as! CarouseCell
        cell.config(object?.data)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? CarouseSectionItem
    }
}
