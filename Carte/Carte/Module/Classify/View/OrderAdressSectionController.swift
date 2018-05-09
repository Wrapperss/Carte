//
//  OrderAdressSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

protocol OrderAdressSectionControllerDelegate: class {
    func didSelectOrderAddressItem()
}

class OrderAdressSectionItem: NormalDiffableItem {
    
    var data: OrderAdressCellRequired
    
    init(data: OrderAdressCellRequired) {
        self.data = data
        super.init()
    }
}

class OrderAdressSectionController: ListSectionController {
    var object: OrderAdressSectionItem?
    
    var delegate: OrderAdressSectionControllerDelegate
    
    init(delegate: OrderAdressSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
        inset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: 80)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: OrderAdressCell = collectionContext?.dequeueReusableCell(withNibName: OrderAdressCell.reuseIdentifier, bundle: nil, for: self, at: index) as! OrderAdressCell
        cell.model = object?.data
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        delegate.didSelectOrderAddressItem()
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? OrderAdressSectionItem
    }
}

