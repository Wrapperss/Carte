//
//  ElementUtil.swift
//  CreamsAgent
//
//  Created by Rawlings on 01/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import IGListKit

// MARK: - ViewWrapper

class ViewWrapper {
    var view: UIView
    var priority: Priority {
        didSet{
            priority.work(view)
        }
    }
    
    init(_ view: UIView, _ priority: Priority = .default) {
        self.view = view
        self.priority = priority
        
        self.priority.work(self.view)
    }
}

// MARK: - Element

protocol Element: class, KeyStorable {
    func generateViewWrapper() -> ViewWrapper
}

/// 不被压缩 & 不被拉伸 的优先级
enum Priority: Float {
    case high = 1000.0
    case `default` = 750.0
    case low = 250.0
    
    func work(_ view: UIView) {
        [UILayoutConstraintAxis.horizontal, UILayoutConstraintAxis.vertical]
            .forEach {
                view.setContentCompressionResistancePriority(rawValue, for: $0)
                view.setContentHuggingPriority(rawValue, for: $0)
        }
    }
}


// MARK: - AssociateItemRequired

protocol AssociateItemRequired {
    weak var associatedItem: ListDiffable? { get set }
}

// MARK: - ElementCombinable

protocol ElementCombinable {
    var box: FormLayoutBox { get }
    var container: UIView { get }
}
extension ElementCombinable {
    
    func combineElements() {
        container.removeSubviews()
        box.elements.forEach { (ele) in
            if let wrapper = ele as? ElementCombinable {
                wrapper.combineElements()
            }
        }
        box.work(with: container)
        
        let size = box.size()
        if size != .zero {
            container.snp.makeConstraints { (make) in
                make.size.equalTo(size)
            }
        }
    }
}
