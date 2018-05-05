//
//  GoodsInfoSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

protocol GoodsInfoSectionControllerDelegate: class {
    func tapToMoreInfo()
}

class GoodsInfoSectionItem: NormalDiffableItem {
    var data: GoodsInfoCellRequired
    
    init(data: GoodsInfoCellRequired) {
        self.data = data
    }
}


class GoodsInfoSectionController: ListSectionController {
    var object: GoodsInfoSectionItem?
    var delegate: GoodsInfoSectionControllerDelegate
    
    init(delegate: GoodsInfoSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: 330)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: GoodsInfoCell = collectionContext?.dequeueReusableCell(withNibName: GoodsInfoCell.reuseIdentifier, bundle: nil, for: self, at: index) as! GoodsInfoCell
        cell.model = object?.data
        cell.delegate = self
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? GoodsInfoSectionItem
    }
}

extension GoodsInfoSectionController: GoodsInfoCellDelegate {
    func moreInfoButtonClick() {
        delegate.tapToMoreInfo()
    }
}
