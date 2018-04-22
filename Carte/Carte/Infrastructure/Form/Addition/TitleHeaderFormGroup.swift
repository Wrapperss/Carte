//
//  TitleHeaderFormGroup.swift
//  CreamsAgent
//
//  Created by Rawlings on 17/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation


class TitleHeaderFormGroup: NormalDiffableItem, FormItemGroupProtocol {
    
    var items: [FormItemProtocol]
    var supplementarys: [FormSupplementary]?
    var headerTitle: String?
    
    init(items: [FormItemProtocol], headerTitle: NSAttributedString, rightElement: Element? = nil, leading: CGFloat = 15, headerHeight: CGFloat, headerColor: UIColor = UIColor.backgroundColor) {
        self.items = items
        self.headerTitle = headerTitle.string
        
        
        if rightElement != nil {
            let box = FormLayoutBox(elements: [TextElement.init(text: headerTitle),
                                               rightElement!],
                                    arrange: TwoArrange(ArrangeCommon(.horizontal, .center), location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding, spaces: (first: leading, last: 0))),
                                    size: CGSize(width: UIScreen.screenWidth, height: headerHeight))
            self.supplementarys = [FormSupplementary(kind: .header,
                                                     backgroundColor: headerColor,
                                                     box: box)]
        } else {
            let box = FormLayoutBox(elements: [TextElement(text: headerTitle)],
                                    arrange: OneArrange(location: (horizontal: .leading(leading), vertical: .center)),
                                    size: CGSize(width: UIScreen.screenWidth, height: headerHeight))
            self.supplementarys = [FormSupplementary(kind: .header,
                                                     backgroundColor: headerColor,
                                                     box: box)]
        }
        super.init()
    }
    
}
