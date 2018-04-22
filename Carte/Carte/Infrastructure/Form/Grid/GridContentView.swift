//
//  GridContentView.swift
//  creams
//
//  Created by Rawlings on 04/01/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation
import IGListKit
import Then
import SwiftRichString
import AttributedLib

class GridContentView: UIView {
    
    fileprivate let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    fileprivate lazy var collectionView: UICollectionView = {
        let cl = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false))
        cl.backgroundColor = .white
        return cl
    }()
    
    fileprivate var item: GridSectionItem?
    
    override var intrinsicContentSize: CGSize {
        adapter.reloadData(completion: nil)
        collectionView.layoutIfNeeded()
        return collectionView.collectionViewLayout.collectionViewContentSize
    }
    
    init(item: GridSectionItem?) {
        self.item = item
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: UIScreen.screenHeight))
        commonInit()
        if item != nil {
            adapter.reloadData(completion: nil)
            invalidateIntrinsicContentSize()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    func updateContent(item: GridSectionItem?, completion: ListUpdaterCompletion?) {
        self.item = item
        adapter.reloadData(completion: completion)
        invalidateIntrinsicContentSize()
    }
}

extension GridContentView: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [item].flatMap { $0 }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return GridSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}


// MARK: - Unit

struct GridUnitData {
    var title: String
    var content: String
    
    var _attrTitle: NSAttributedString?
    var _attrContent: NSAttributedString?
  
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    init(attrTitle: NSAttributedString, attrContent: NSAttributedString) {
        _attrTitle = attrTitle
        _attrContent = attrContent
        self.title = attrTitle.string
        self.content = attrTitle.string
    }
    
    var attrTitle: NSAttributedString {
        return self._attrTitle == nil ? title.set(style: UIService.Grid.unitTitleStyle) : self._attrTitle!
    }
    
    var attrContent: NSAttributedString {
        return  self._attrContent == nil ? content.set(style: UIService.Grid.unitContentStyle) : self._attrContent!
    }
    
}

class GridSectionItem: NormalDiffableItem {
    
    open var datas: [GridUnitData]
    
    init(datas: [GridUnitData] = []){
        self.datas = datas
        super.init()
    }
    
    func size(index: Int, containerWidth: CGFloat) -> CGSize {
        
        let titleSize = datas[index].attrTitle.calculateSize(.singleLine)
        let contentSize = datas[index].attrContent.calculateSize(.singleLine)
        
        let cw = UIService.Grid.threeLayoutRule(contentWidth: max(titleSize.width, contentSize.width),
                                                totalWidth: containerWidth,
                                                horizontalSpace: UIService.Grid.spaceHorizontal)
        
        let h = titleSize.height + contentSize.height + UIService.Grid.spaceVertical.small 
        
        return CGSize(width: min(containerWidth, cw), height: h)
    }
}

class GridSectionController: ListSectionController {
    
    var obj: GridSectionItem?
    
    override init() {
        super.init()
        self.minimumLineSpacing = UIService.Grid.spaceVertical.greater
        self.minimumInteritemSpacing = UIService.Grid.spaceHorizontal
        self.inset = UIService.Grid.edge
    }
    
    override func numberOfItems() -> Int {
        guard let width = collectionContext?.containerSize.width, width > CGFloat(0) else {
            return 0
        }
        return obj?.datas.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = self.collectionContext else {
            fatalError("No CollectionContext!")
        }
        return obj?.size(index: index, containerWidth: collectionContext.insetContainerSize.width - inset.left - inset.right) ?? .zero
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let collectionContext = self.collectionContext else {
            fatalError("No CollectionContext!")
        }
        
        let cell = collectionContext.dequeueReusableCell(of: GridUnitCell.self, for: self, at: index) as! GridUnitCell
        cell.model = obj?.datas[index]
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        obj = object as? GridSectionItem
    }
}


class GridUnitCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        titleLabel.snp.makeConstraints { (mk) in
            mk.left.top.right.equalToSuperview()
        }
        contentLabel.snp.makeConstraints { (mk) in
            mk.left.bottom.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: GridUnitData? {
        didSet{
            titleLabel.attributedText = model?.attrTitle ?? NSAttributedString()
            contentLabel.attributedText = model?.attrContent ?? NSAttributedString()
        }
    }
}
