//
//  UIService.swift
//  creams
//
//  Created by Rawlings on 04/01/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation
import UIKit
import SwiftRichString

struct UIService {
    struct Color {}
    struct Structure {}
    struct Element {}
    struct Arrange {}
    struct Grid {}
}


extension UIService.Grid {
    
    static let unitTitleStyle = Style {
        $0.font = FontAttribute(font: UIFont.systemFont(ofSize: 12, weight: UIFontWeightRegular))
        $0.align = .left
        $0.color = UIColor.steel
    }
    
    static let unitContentStyle = Style {
        $0.font = FontAttribute(font: UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular))
        $0.align = .left
        $0.color = UIColor.charcoalGrey
    }
    
    static let edge = UIEdgeInsetsMake(15, 15, 15, 15)
    static let space = (max: CGFloat(15), mid: CGFloat(10), min: CGFloat(5))
    static let spaceHorizontal = space.mid
    static let spaceVertical = (greater: space.max, small: space.min)
    
    
    /// Grid Layout cell's width calculating
    ///
    /// - Parameters:
    ///   - totalWidth: cell container's real width ( without edge insets )
    /// - Returns: fitting width
    static func threeLayoutRule(contentWidth: CGFloat, totalWidth: CGFloat, horizontalSpace: CGFloat) -> CGFloat {
        let total = totalWidth - horizontalSpace * 2
        let ratio = contentWidth / total
        if ratio >= 1 { return totalWidth }
        if contentWidth * totalWidth == 0 {
            return 1/3 * total
        }
        let temp = ceil(ratio * 3)
        let spaces = (temp - 1) * horizontalSpace
        return temp / 3 * total + spaces
    }
    
}


extension UIService.Structure {
    
    struct View {
        var backgroundColor: UIColor
        var cornerRadius: CGFloat
    }
}
