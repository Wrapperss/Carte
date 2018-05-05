//
//  UILabel+Extension.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation

extension UILabel {
    func setLineSpacing(_ lineSpacing: CGFloat) {
        guard let text = text, lineSpacing > 0.01 else {
            return
        }
        
        let textAtr = NSMutableAttributedString(string: text)
        textAtr.addAttribute(NSFontAttributeName, value: self.font, range: NSRange(location: 0, length: text.length))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineBreakMode = self.lineBreakMode
        paragraphStyle.alignment = self.textAlignment
        textAtr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: text.length))
        self.attributedText = textAtr
    }
}
