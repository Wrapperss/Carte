//
//  GridWrapperSection.swift
//  creams
//
//  Created by Rawlings on 15/01/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation
import IGListKit

class GridWrapperSectionItem: NormalDiffableItem {
    var data: GridSectionItem
    var separatorLine: SeparatorLine?

    
    init(data: GridSectionItem, separatorLine: SeparatorLine? = nil) {
        self.data = data
        self.separatorLine = separatorLine
    }
}


class GridWrapperSectionController: ListSectionController {
    
    var obj: GridWrapperSectionItem?
    
    init(inset: UIEdgeInsets = .zero) {
        super.init()
        self.inset = inset
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = self.collectionContext else {
            fatalError("No CollectionContext!")
        }
        
        let calculateInstance = GridContentView(item: obj?.data)
        calculateInstance.snp.makeConstraints { (mk) in
            mk.width.equalTo(collectionContext.insetContainerSize.width - inset.left - inset.right)
        }
        return calculateInstance.intrinsicContentSize
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let collectionContext = self.collectionContext else {
            fatalError("No CollectionContext!")
        }
        
        let cell = collectionContext.dequeueReusableCell(of: GridWrapperCell.self, for: self, at: index) as! GridWrapperCell
        cell.model = obj
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        obj = object as? GridWrapperSectionItem
    }
    
}


class GridWrapperCell: UICollectionViewCell {
    
    private var content = GridContentView(item: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        backgroundColor = .white
        contentView.addSubview(content)
        content.snp.makeConstraints { (mk) in
            mk.edges.equalToSuperview()
        }
        content
            .findSubviewsRecursive(UIScrollView.self)
            .forEach { $0.isUserInteractionEnabled = false }
//            .forEach { $0.isScrollEnabled = false }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews
            .filter { !($0 is GridContentView) }
            .forEach {
                $0.removeFromSuperview()
        }
    }
    
    var model: GridWrapperSectionItem? {
        didSet{
            if let model = model {
                content.alpha = 0
                content.updateContent(item: model.data, completion: { [unowned self] (_) in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.content.alpha = 1
                    })
                })
                if let separator = model.separatorLine {
                    separator.work(with: self)
                }
            }
        }
    }
}
