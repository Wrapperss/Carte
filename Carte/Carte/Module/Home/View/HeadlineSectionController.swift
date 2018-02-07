//
//  HeadlineSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

class HeadlineSectionItem: NormalDiffableItem {
    var data: HeadlineRequired
    
    init(_ data: HeadlineRequired) {
        self.data = data
    }
}


class HeadlineSectionController: ListSectionController {
    var object: HeadlineSectionItem?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: HeadlineCell.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: HeadlineCell = collectionContext?.dequeueReusableCell(of: HeadlineCell.self, for: self, at: index) as! HeadlineCell
        cell.config(object?.data)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? HeadlineSectionItem
    }
}
