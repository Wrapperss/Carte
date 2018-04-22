//
//  FormUtil.swift
//  CreamsAgent
//
//  Created by Rawlings on 30/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import IGListKit

// MARK: - FormLayoutBox

struct FormLayoutBox {
    let elements: [Element]
    let arrange: Arrangeable
    let size: ()->(CGSize)
    
    init(elements: [Element], arrange: Arrangeable, size: @escaping @autoclosure () -> CGSize) {
        self.elements = elements
        self.arrange = arrange
        self.size = size
    }
    
    func work(with container: UIView) {
        arrange.arrange(elements: elements.map { $0.generateViewWrapper() }, to: container)
    }
}

// MARK: - FormItemProtocol

struct FormItemConfig {
    var separatorLine: SeparatorLine? = nil
    var backgroundColor: UIColor = UIColor.white
    var contentAlpha: CGFloat = 1
    
    func work(cell: UICollectionViewCell) {
        cell.backgroundColor = backgroundColor
        cell.contentView.alpha = contentAlpha
        if let sep = separatorLine {
            sep.work(with: cell.contentView)
        }
    }
}

protocol FormItemProtocol: ListDiffable, KeyStorable {
    var box: FormLayoutBox { get }
    var config: FormItemConfig { get set }
}

protocol FormItemGroupProtocol: ListDiffable {
    var items: [FormItemProtocol] { get }
    var supplementarys: [FormSupplementary]? { get }
}

struct FormSupplementary {
    let kind: Kind
    let backgroundColor: UIColor
    let box: FormLayoutBox
    
    enum Kind {
        case header
        case footer
        
        var associatedKind: String {
            switch self {
            case .header:
                return UICollectionElementKindSectionHeader
            case .footer:
                return UICollectionElementKindSectionFooter
            }
        }
    }
}

extension Array where Element: FormItemProtocol {

    func configLiteral(closure: (FormItemProtocol) -> Void) {
        self.forEach { (item) in
            closure(item)
        }
    }
}

class WrapperFormItem: FormItem {
    
}

// MARK: - FormItem

class FormItem: NormalDiffableItem, FormItemProtocol {
    
    var box: FormLayoutBox
    var config: FormItemConfig
    
    init(box: FormLayoutBox, config: FormItemConfig = FormItemConfig()) {
        self.box = box
        self.config = config
        super.init()
        box.elements.forEach { (ele) in
            if var ele = ele as? AssociateItemRequired {
                ele.associatedItem = self
            }
        }
    }
    
    convenience init(box: FormLayoutBox,
                     separator: SeparatorLine? = SeparatorLine(),
                     backgroundColor: UIColor = UIColor.white,
                     contentAlpha: CGFloat = 1)
    {
        self.init(box: box,
                  config: FormItemConfig(separatorLine: separator,
                                         backgroundColor: backgroundColor,
                                         contentAlpha: contentAlpha))
    }
    
    convenience init(elements: [Element],
                     arrange: Arrangeable,
                     height: CGFloat = 44,
                     separator: SeparatorLine? = SeparatorLine(),
                     backgroundColor: UIColor = .white)
    {
        self.init(box: FormLayoutBox(elements: elements, arrange: arrange, size: CGSize(width: UIScreen.screenWidth, height: height)),
                  separator: separator,
                  backgroundColor:backgroundColor)
    }
    
    convenience init(elements: [Element],
                     height: CGFloat = 44,
                     separator: SeparatorLine? = SeparatorLine(),
                     backgroundColor: UIColor = .white,
                     arrange: Arrangeable)
    {
        self.init(box: FormLayoutBox(elements: elements, arrange: arrange, size: CGSize(width: UIScreen.screenWidth, height: height)),
                  separator: separator,
                  backgroundColor:backgroundColor)
    }
    
    // 自定义Size
    convenience init(elements: [Element],
                     arrange: Arrangeable,
                     size: CGSize,
                     separator: SeparatorLine? = SeparatorLine(),
                     backgroundColor: UIColor = .white)
    {
        self.init(box: FormLayoutBox(elements: elements, arrange: arrange, size: size),
                  separator: separator,
                  backgroundColor:backgroundColor)
    }
    
}

// MARK: - FormCell

class FormCell: UICollectionViewCell {
    
    var item: FormItemProtocol? {
        didSet{
            setupElements()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        guard let formItem = item else {
            return
        }
        formItem.box.work(with: contentView)
        formItem.config.work(cell: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.removeSubviews()
        contentView.alpha = 1
    }
}

class FormReusableView: UICollectionReusableView {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeSubviews()
    }
}

// MARK: - FormSectionController

protocol FormSectionControllerDelegate: class {
    func didSelectForm(item: FormItemProtocol, in sectionController: FormSectionController)
}

class FormSectionController: ListSectionController {
    
    var item: FormItemProtocol?
    var group: FormItemGroupProtocol?
    weak var delegate: FormSectionControllerDelegate?
    var scrollDirection: UICollectionViewScrollDirection
    
    init(delegate: FormSectionControllerDelegate? = nil, inset: UIEdgeInsets = .zero, scrollDirection: UICollectionViewScrollDirection = .vertical) {
        self.scrollDirection = scrollDirection
        super.init()
        self.delegate = delegate
        self.supplementaryViewSource = self
        self.inset = inset
    }


    internal override func numberOfItems() -> Int {
        if let group = group {
            return group.items.count
        }
        if let _ = item {
            return 1
        }
        return 0
    }
    
    internal override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = self.collectionContext else {
            fatalError("No CollectionContext!")
        }
        var size: CGSize = .zero
        
        if let group = group {
            size = group.items[index].box.size()
        }
        if let item = item {
            size = item.box.size()
        }

        let safeW = min(collectionContext.insetContainerSize.width - inset.left - inset.right, size.width)
        let safeH = min(collectionContext.insetContainerSize.height - inset.top - inset.bottom, size.height)
        
        switch scrollDirection {
        case .horizontal:
            return CGSize(width: size.width, height: safeH)
        case .vertical:
            return CGSize(width: safeW, height: size.height)
        }
    }
    
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let collectionContext = self.collectionContext else {
            fatalError("No CollectionContext!")
        }
        
        let cell = collectionContext.dequeueReusableCell(of: FormCell.self, for: self, at: index) as! FormCell
        
        if let group = group {
            cell.item = group.items[index]
        }
        if let item = item {
            cell.item = item
        }
        
        return cell
    }
    
    internal override func didUpdate(to object: Any) {
        
        if let group = object as? FormItemGroupProtocol {
            self.group = group
            return
        }
        if let item = object as? FormItemProtocol {
            self.item = item
            return
        }
        
        fatalError("No Suitable SectionItem Matching")
    }
    
    internal override func didSelectItem(at index: Int) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: false)
        
        if let group = group {
            delegate?.didSelectForm(item: group.items[index], in: self)
        }
        if let item = item {
            delegate?.didSelectForm(item: item, in: self)
        }
    }
    
}

extension FormSectionController: ListSupplementaryViewSource {
    
    func supportedElementKinds() -> [String] {
        guard let supp = group?.supplementarys else {
            return []
        }
        return supp.map { $0.kind.associatedKind }
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let supp = group?.supplementarys else {
            return FormReusableView()
        }
        let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                                       for: self,
                                                                       class: FormReusableView.self,
                                                                       at: index)
        view?.backgroundColor = supp[index].backgroundColor
        supp[index].box.work(with: view!)
        return view!
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        guard let collectionContext = self.collectionContext else {
            fatalError("No CollectionContext!")
        }
        guard let supp = group?.supplementarys else {
            return .zero
        }
        let size = supp[index].box.size()
        
        let safeW = min(collectionContext.insetContainerSize.width - inset.left - inset.right, size.width)
        let safeH = min(collectionContext.insetContainerSize.height - inset.top - inset.bottom, size.height)
        
        switch scrollDirection {
        case .horizontal:
            return CGSize(width: size.width, height: safeH)
        case .vertical:
            return CGSize(width: safeW, height: size.height)
        }
    }
}

