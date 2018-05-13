//
//  HomeSingelSectoinController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/13.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

protocol HomeSingelSectionControllerDelegate: class {
    func didSelectSingleItem(_ goodsId: Int)
}

class HomeSingelSectionItem: NormalDiffableItem {
    var data: HomeSingelCellRequired
    var goodsId: Int
    
    init(data: HomeSingelCellRequired, goodsId: Int) {
        self.data = data
        self.goodsId = goodsId
    }
}

class HomeSingelSectionController: ListSectionController {
    
    var object: HomeSingelSectionItem?
    
    var delegate: HomeSingelSectionControllerDelegate
    
    init(delegate: HomeSingelSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
        self.inset = UIEdgeInsetsMake(10, 0, 0, 0)
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: 310)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: HomeSingelCell = collectionContext?.dequeueReusableCell(withNibName: HomeSingelCell.reuseIdentifier, bundle: nil, for: self, at: index) as! HomeSingelCell
        cell.model = object?.data
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? HomeSingelSectionItem
    }
    
    override func didSelectItem(at index: Int) {
        guard let goodsId = object?.goodsId else {
            return
        }
        delegate.didSelectSingleItem(goodsId)
    }
}
