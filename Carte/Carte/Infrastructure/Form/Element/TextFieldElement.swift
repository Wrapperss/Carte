//
//  TextFieldElement.swift
//  CreamsAgent
//
//  Created by Rawlings on 25/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import IGListKit
import RxCocoa

protocol TextFieldElementDelegate: class {
    
    func textFieldElementDidBeginEditing(element: TextFieldElement, tf: UITextField, associatedItem: ListDiffable?)
    func textFieldElementEditingChanged(element: TextFieldElement, tf: UITextField, associatedItem: ListDiffable?)
    func textfieldElementShouldBeginEditing(element: TextFieldElement, tf: UITextField, associatedItem: ListDiffable?) -> Bool
}
extension TextFieldElementDelegate {
    
    func textFieldElementDidBeginEditing(element: TextFieldElement, tf: UITextField, associatedItem: ListDiffable?) {}
    func textFieldElementEditingChanged(element: TextFieldElement, tf: UITextField, associatedItem: ListDiffable?) {}
    func textfieldElementShouldBeginEditing(element: TextFieldElement, tf: UITextField, associatedItem: ListDiffable?) -> Bool { return true }
}


class TextFieldElement: NSObject, Element, AssociateItemRequired {
    
    weak var associatedItem: ListDiffable?
    private var priority: Priority = .default
    
    let holder: String?
    var text: String? {
        didSet{
            if textField?.text != text { // warning: it's necessary to break editing action invoke cycle
                textField?.text = text
                textField?.sendActions(for: .editingChanged)
            }
        }
    }
    let size: CGSize
    let keyboard: UIKeyboardType
    let config: ((UITextField)->())?
    weak var delegate: TextFieldElementDelegate?
    var textField: UITextField?
    
    open var value: ControlProperty<String?>? {
        return textField?.rx.text
    }
    
    init(holder: String?, text: String? = nil, size: CGSize = .zero, keyboard: UIKeyboardType = .default, delegate: TextFieldElementDelegate? = nil, config: ((UITextField)->())? = nil) {
        self.holder = holder
        self.text = text
        self.size = size
        self.delegate = delegate
        self.keyboard = keyboard
        self.config = config
    }
    
    @discardableResult
    public func priority(_ priority: Priority) -> TextFieldElement {
        self.priority = priority
        return self
    }
    
    func generateViewWrapper() -> ViewWrapper {
        if textField == nil {
            textField = UITextField()
            textField!.addTarget(self, action: #selector(textFieldEditingChanged(tf:)), for: .editingChanged)
        }
        setup(tf: textField!)
        
        return ViewWrapper(textField!, priority)
    }
    
    open func setup(tf: UITextField) {
        if textField == nil {
            textField = tf
        }
        tf.placeholder = holder ?? ""
        tf.text = text ?? ""
        tf.sendActions(for: .editingChanged)
        tf.borderStyle = .none
        tf.backgroundColor = .clear
        tf.textAlignment = .left
        tf.textColor = UIColor.charcoalGrey
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.keyboardType = keyboard
        tf.returnKeyType = .done
        
        tf.delegate = self
        
        if size != .zero {
            tf.snp.makeConstraints { (make) in
                make.size.equalTo(size)
            }
        }
        
        config?(tf)
    }
    
    @objc func textFieldEditingChanged(tf: UITextField) {
        text = tf.text
        delegate?.textFieldElementEditingChanged(element: self, tf: tf, associatedItem: associatedItem)
    }
}

extension TextFieldElement: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldElementDidBeginEditing(element: self, tf: textField, associatedItem: associatedItem)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return delegate?.textfieldElementShouldBeginEditing(element: self, tf: textField, associatedItem: associatedItem) ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

