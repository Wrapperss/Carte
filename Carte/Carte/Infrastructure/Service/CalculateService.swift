//
//  CalculateService.swift
//  creams
//
//  Created by Rawlings on 04/01/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation
import UIKit
import SwiftRichString


struct CalculateService {
    struct Text {}
}


extension CalculateService.Text {
    
    enum Base {
        case width(CGFloat)
        case height(CGFloat)
        case singleLine
        
        var baseSize: CGSize {
            switch self {
            case let .width(w):
                return CGSize(width: w, height: CGFloat.greatestFiniteMagnitude)
            case let .height(h):
                return CGSize(width: CGFloat.greatestFiniteMagnitude, height: h)
            case .singleLine:
                return CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            }
        }
    }
    
    static func calculateSize(_ text: NSAttributedString, _ base: Base) -> CGSize {
        var options: NSStringDrawingOptions
        if case .singleLine = base {
            options = []
        } else {
            options = [.usesLineFragmentOrigin]
        }
        let size = text.boundingRect(with: base.baseSize, options: options, context: nil)
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
    
}

extension NSAttributedString {
    
    func calculateSize(_ base: CalculateService.Text.Base) -> CGSize {
        return CalculateService.Text.calculateSize(self, base)
    }
}
