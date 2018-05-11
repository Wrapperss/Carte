//
//  HomeCategoarySectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/11.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

protocol HomeCategoarySectionControllerDelegate: class {
    func didSelectCategorySectionItem(_ category: Category)
}

class HomeCategoarySectionItem: NormalDiffableItem {
    
    var data: HomeCategoaryCellRequired
    var category: Category
    
    init(data: HomeCategoaryCellRequired, category: Category) {
        self.data = data
        self.category = category
    }
}

class HomeCategoarySectionController: ListSectionController {
    var object: HomeCategoarySectionItem?
    
    var delegate: HomeCategoarySectionControllerDelegate
    
    init(delegate: HomeCategoarySectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: 310)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: HomeCategoaryCell = collectionContext?.dequeueReusableCell(withNibName: HomeCategoaryCell.reuseIdentifier, bundle: nil, for: self, at: index) as! HomeCategoaryCell
        cell.model = object?.data
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let category = object?.category else {
            return
        }
        delegate.didSelectCategorySectionItem(category)
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? HomeCategoarySectionItem
    }
}
