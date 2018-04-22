//
//  WrapperElement.swift
//  CreamsAgent
//
//  Created by Rawlings on 23/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import IGListKit

class WrapperElement: Element, ElementCombinable, AssociateItemRequired {
    
    var box: FormLayoutBox
    var container: UIView
    
    static var defaultContainer: UIView {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    
    weak var associatedItem: ListDiffable? {
        didSet{
            box.elements.forEach { (ele) in
                if var ele = ele as? AssociateItemRequired {
                    ele.associatedItem = associatedItem
                }
            }
        }
    }
    
    init(elements: [Element], arrange: Arrangeable, size: CGSize, container: UIView = defaultContainer) {
        self.box = FormLayoutBox(elements: elements, arrange: arrange, size: size)
        self.container = container
    }
    
    func generateViewWrapper() -> ViewWrapper {
        combineElements()
        return ViewWrapper(container)
    }
}
