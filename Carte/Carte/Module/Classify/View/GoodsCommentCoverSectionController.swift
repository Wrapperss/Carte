//
//  GoodsCommentCoverSectionController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

protocol GoodsCommentCoverSectionControllerDelegate: class {
    func didSelectCommentCoverItem()
}

class GoodsCommentCoverSectionItem: NormalDiffableItem {
    var data: GoodsCommentCoverCellRequired
    var shap: GoodsCommentCoverCell.Shap
    
    init(data: GoodsCommentCoverCellRequired, shap: GoodsCommentCoverCell.Shap = .cover) {
        self.data = data
        self.shap = shap
        super.init()
    }
    
}

class GoodsCommentCoverSectionController: ListSectionController {
    var object: GoodsCommentCoverSectionItem?
    var delegate: GoodsCommentCoverSectionControllerDelegate?
    
    init(delegate: GoodsCommentCoverSectionControllerDelegate? = nil) {
        self.delegate = delegate
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return object != nil ? 1 : 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.screenWidth,
                      height: GoodsCommentCoverCell.calculateHeight(content: object?.data.content ?? "", shap: object?.shap ?? .cover))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: GoodsCommentCoverCell = collectionContext?.dequeueReusableCell(withNibName: GoodsCommentCoverCell.reuseIdentifier, bundle: nil, for: self, at: index) as! GoodsCommentCoverCell
        cell.model = object?.data
        cell.shap = object?.shap ?? .cover
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.didSelectCommentCoverItem()
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? GoodsCommentCoverSectionItem
    }
}
