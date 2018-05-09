//
//  OrderListFactory.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

extension DataFactory.viewRequired {
    
}

extension DataFactory.sectionItem {
    
    public static func prepareOrderListCell(_ orderContent: OrderContent) -> [ListDiffable] {
        var source = [ListDiffable]()
        
        let blankItem = FormItem.blank(height: 10, backgroundColor: .backgroundColor)
        source.append(blankItem)
        
        let titleItem = FormItem(elements: [TextElement(text: NSAttributedString.attribute("订单编号:\(orderContent.order?.id ?? 0)", .black, fontSize: 17))],
                                 arrange: OneArrange(location: (horizontal: OneArrange.AxisLocation.leading(10), vertical: OneArrange.AxisLocation.center)),
                                 height: 50,
                                 separator: SeparatorLine(position: .bottom, margin: (0,0), height: 0.5))
        source.append(titleItem)
        
        for orderGood in orderContent.orderGoods ?? [] {
            let orderItem = OrderSectionItem(data: orderGood)
            source.append(orderItem)
        }
        return source
    }
    
}

