//
//  TextElement.swift
//  CreamsAgent
//
//  Created by Rawlings on 20/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import RxSwift
import YYText
import RxCocoa

class TextElement: Element {
    
    var text: NSAttributedString {
        didSet{
            DispatchQueue.main.async {
                self.label?.attributedText = self.text
                self.label?.lineBreakMode = .byTruncatingTail
            }
        }
    }
    var label: UILabel?
    let config: ((UILabel)->())?
    var size: CGSize?
    var textAlignment: NSTextAlignment
    
    private var priority: Priority = .default
    
    init(text: NSAttributedString, size: CGSize? = nil, textAlignment: NSTextAlignment = .left, config: ((UILabel)->())? = nil) {
        self.text = text
        self.config = config
        self.size = size
        self.textAlignment = textAlignment
    }
    
    @discardableResult
    public func priority(_ priority: Priority) -> TextElement {
        self.priority = priority
        return self
    }
    
    
    /// if initialed text is empty, this won't work (because zero Range can't store Attributes)
    ///
    open func updateText(_ plainText: String) {
        text.enumerateAttributes(in: NSMakeRange(0, text.length),
                                 options: []) { (attrs, range, _) in
                                    text = NSAttributedString(string: plainText, attributes: attrs)
        }
    }
    
    open func updateColor(_ color: UIColor) {
        let temp = NSMutableAttributedString(attributedString: text)
        temp.addAttribute(NSForegroundColorAttributeName, value: color, range: text.yy_rangeOfAll())
        text = temp
    }
    
    open func updateFont(fontSize: CGFloat, fontWeight: CGFloat = UIFontWeightRegular) {
        let temp = NSMutableAttributedString(attributedString: text)
        temp.addAttribute(NSFontAttributeName,
                          value: UIFont.systemFont(ofSize: fontSize, weight: fontWeight),
                          range: text.yy_rangeOfAll())
        text = temp
    }
    
    func generateViewWrapper() -> ViewWrapper {
        if label == nil {
            label = UILabel()
        }
        label!.attributedText = text
        label!.lineBreakMode = .byTruncatingTail
        label!.textAlignment = textAlignment
        config?(label!)
        
        if let size = size, size != .zero {
            label!.snp.makeConstraints { (make) in
                make.size.equalTo(size)
            }
        }
        return ViewWrapper(label!, priority)
    }
}

extension Reactive where Base: TextElement {
    
    internal var text: UIBindingObserver<Base, String> {
        return UIBindingObserver(UIElement: base, binding: { (component, text) in
            component.updateText(text)
        })
    }
}
