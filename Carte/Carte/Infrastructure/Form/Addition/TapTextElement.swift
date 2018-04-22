//
//  TapTextElement.swift
//  CreamsAgent
//
//  Created by Rawlings on 07/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import IGListKit


extension WrapperElement {
    
    static func tapTextElement(text: NSAttributedString, config: ((UILabel)->())? = nil, tapAction: (()->())?) -> WrapperElement {
        
        let size = CGSize(width: 164, height: 30)
        
        let text = TextElement(text: text, config: config)
        let cover = ButtonElement(btn: UIButton(), size: size, tapAction: tapAction)
        
        return WrapperElement(elements: [text, cover],
                              arrange: CoverArrange(),
                              size: size)
    }
}
