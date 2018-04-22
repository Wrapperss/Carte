////
////  TextViewElement.swift
////  CreamsAgent
////
////  Created by Rawlings on 27/11/2017.
////  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
////
//
//import Foundation
//import IGListKit
//import RSKGrowingTextView
//
//
//
//protocol TextViewElementDelegate: class {
//    
//}
//
//
//class TextViewElement: Element, AssociateItemRequired {
//    
//    weak var associatedItem: ListDiffable?
//    
//    let holder: String?
//    var text: String? {
//        didSet{
//            if textView?.text != text {
//                textView?.text = text
//            }
//        }
//    }
//    let size: CGSize
//    let keyboard: UIKeyboardType
//    let config: ((RSKGrowingTextView)->())?
//    weak var delegate: TextViewElementDelegate?
//    var textView: RSKGrowingTextView?
//    
//    init(holder: String?, text: String? = nil, size: CGSize = .zero, keyboard: UIKeyboardType = .default, delegate: TextViewElementDelegate? = nil, config: ((RSKGrowingTextView)->())? = nil) {
//        self.holder = holder
//        self.text = text
//        self.size = size
//        self.delegate = delegate
//        self.keyboard = keyboard
//        self.config = config
//    }
//    
//    open func setup(tv: RSKGrowingTextView) {
//        textView = tv
//        
//        tv.placeholder = holder ?? ""
//        tv.text = text ?? ""
//        tv.borderStyle = .none
//        tv.backgroundColor = .clear
//        tv.textAlignment = .left
//        tv.textColor = UIColor.charcoalGrey
//        tv.font = UIFont.systemFont(ofSize: 14)
//        
//        tv.keyboardType = keyboard
//        
//        tv.addta
//        tv.addTarget(self, action: #selector(textFieldEditingChanged(tf:)), for: .editingChanged)
//        tv.delegate = self
//        
//        if size != .zero {
//            tf.snp.makeConstraints { (make) in
//                make.size.equalTo(size)
//            }
//        }
//        
//        config?(tv)
//    }
//    
//    
//    func generateViewWrapper() -> ViewWrapper {
//        
//        let tv = RSKGrowingTextView(frame: .zero)
//        setup(tv: tv)
//        
//        return ViewWrapper(tf)
//    }
//}

