//
//  BlankFormItem.swift
//  CreamsAgent
//
//  Created by Rawlings on 08/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation

extension FormItem {
    
    private struct BlankArrange: Arrangeable {
        func arrange(elements: [UIView], to container: UIView) {}
    }
    
    
    static func blank(size: CGSize,
                      backgroundColor: UIColor = UIColor.white,
                      separator: SeparatorLine? = nil)
        -> FormItem
    {
        return FormItem(box: FormLayoutBox(elements: [], arrange: BlankArrange(), size: size),
                        separator: separator,
                        backgroundColor: backgroundColor)
    }
    
    
    static func blank(height: CGFloat,
                      backgroundColor: UIColor = UIColor.white,
                      separator: SeparatorLine? = nil)
        -> FormItem
    {
        return FormItem.blank(size: CGSize(width: UIScreen.screenWidth, height: height),
                              backgroundColor: backgroundColor,
                              separator: separator)
    }
}


