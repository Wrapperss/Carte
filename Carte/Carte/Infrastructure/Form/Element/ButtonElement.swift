//
//  ButtonElement.swift
//  CreamsAgent
//
//  Created by Rawlings on 23/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import IGListKit


protocol ButtonElementDelegate: class {
    func buttonElementTaped(element: ButtonElement, btn: UIButton, associatedItem: ListDiffable?)
}

class ButtonElement: Element, AssociateItemRequired {
    
    weak var associatedItem: ListDiffable?
    private var priority: Priority = .default
    // required
    var size: CGSize?
    var tapAction: (()->())?
    weak var delegate: ButtonElementDelegate?
    // optional
    var btn: UIButton?
    var config: ((UIButton)->())?
    
    init(size: CGSize? = nil, tapAction: (()->())? = nil, delegate: ButtonElementDelegate? = nil) {
        self.size = size
        self.tapAction = tapAction
        self.delegate = delegate
    }
    
    convenience init(btn: UIButton, size: CGSize? = nil, tapAction: (()->())? = nil, delegate: ButtonElementDelegate? = nil) {
        self.init(size: size, tapAction: tapAction, delegate: delegate)
        self.btn = btn
    }
    
    convenience init(config: ((UIButton)->())?, size: CGSize? = nil, tapAction: (()->())? = nil, delegate: ButtonElementDelegate? = nil) {
        self.init(size: size, tapAction: tapAction, delegate: delegate)
        self.config = config
    }
    
    @discardableResult
    public func priority(_ priority: Priority) -> ButtonElement {
        self.priority = priority
        return self
    }
    
    func generateViewWrapper() -> ViewWrapper {
        if btn == nil {
            self.btn = UIButton(type: .custom)
            self.config?(self.btn!)
        }
        if let size = size, size != .zero {
            btn?.snp.makeConstraints { (make) in
                make.size.equalTo(size)
            }
        }
        btn?.whenTapped { [weak self] in
            if let `self` = self {
                self.tapAction?()
                self.delegate?.buttonElementTaped(element: self, btn: self.btn!, associatedItem: self.associatedItem)
            }
        }
        return ViewWrapper(btn!, priority)
    }
    
}

extension ButtonElement: Equatable {
    
    static func ==(lhs: ButtonElement, rhs: ButtonElement) -> Bool {
        return lhs === rhs
    }
}
