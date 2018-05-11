//
//  OrderListFactory.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit
import Then

extension DataFactory.viewRequired {
    
}

extension DataFactory.sectionItem {
    
    public static func prepareOrderListCell(_ orderContent: OrderContent, status: OrderListController.Status) -> [ListDiffable] {
        var source = [ListDiffable]()
        
        let blankItem = FormItem.blank(height: 10, backgroundColor: .backgroundColor)
        source.append(blankItem)
        
        if status == .all {
            let titleItem = FormItem(elements: [TextElement(text: NSAttributedString.attribute("订单编号:\(orderContent.order?.id ?? 0)", .black, fontSize: 17)),
                                                TextElement.init(text: NSAttributedString.attribute(orderContent.order?.status ?? "", UIColor(r: 252, g: 29, b: 44), fontSize: 14))],
                                     arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                                         location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding,
                                                                                                 spaces: (first: 10, last: 10))),
                                     height: 50,
                                     separator: SeparatorLine(position: .bottom, margin: (0,0), height: 0.5))
            source.append(titleItem)
        } else {
            let titleItem = FormItem(elements: [TextElement(text: NSAttributedString.attribute("订单编号:\(orderContent.order?.id ?? 0)", .black, fontSize: 17))],
                                     arrange: OneArrange(location: (horizontal: OneArrange.AxisLocation.leading(10), vertical: OneArrange.AxisLocation.center)),
                                     height: 50,
                                     separator: SeparatorLine(position: .bottom, margin: (0,0), height: 0.5))
            source.append(titleItem)
        }
        
        var allCount: Int = 0
        
        for orderGood in orderContent.orderGoods ?? [] {
            let orderItem = OrderSectionItem(data: orderGood)
            source.append(orderItem)
            allCount = allCount + (orderGood.quantity ?? 0)
        }
        
        let totalItem = FormItem(elements: [TextElement(text: NSAttributedString.attribute("共\(allCount)商品，合计￥\(orderContent.order?.payment ?? 0.0)(包含运费：￥\(orderContent.order?.fare ?? 0.0))",
                                                                                            .black,
                                                                                           fontSize: 14))],
                                      arrange: OneArrange(location: (horizontal: OneArrange.AxisLocation.trailing(10), vertical: OneArrange.AxisLocation.center)),
                                      height: 50,
                                      separator: SeparatorLine(position: .top, margin: (0,0), height: 0.5))
        source.append(totalItem)
        
        //待发货，待收货，待反馈，退款中
        guard let stutus = orderContent.order?.status else {
            return source
        }

        
        
        switch stutus {
        case "待付款":
            let actionItem = OrderContentFormItem(elements: [TextElement(text: NSAttributedString.attribute("去支付", UIColor.init(r: 252, g: 29, b: 44), fontSize: 17))],
                                                  arrange: OneArrange(location: (horizontal: OneArrange.AxisLocation.center,
                                                                                 vertical: OneArrange.AxisLocation.center)), height: 50, separator: SeparatorLine(position: .top,
                                                                                                                                                                  margin: (0,0),
                                                                                                                                                                  height: 0.5))
            actionItem.orderContent = orderContent
            source.append(actionItem)
        case "待收货":
            let actionItem = OrderContentFormItem(elements: [TextElement(text: NSAttributedString.attribute("确认收货", UIColor.init(r: 252, g: 29, b: 44), fontSize: 17))],
                                                  arrange: OneArrange(location: (horizontal: OneArrange.AxisLocation.center,
                                                                                 vertical: OneArrange.AxisLocation.center)), height: 50, separator: SeparatorLine(position: .top,
                                                                                                                                                                  margin: (0,0),
                                                                                                                                                                  height: 0.5))
            actionItem.orderContent = orderContent
            source.append(actionItem)
        case "待反馈":
            let actionItem = OrderContentFormItem(elements: [TextElement(text: NSAttributedString.attribute("去反馈", UIColor.init(r: 252, g: 29, b: 44), fontSize: 17))],
                                                  arrange: OneArrange(location: (horizontal: OneArrange.AxisLocation.center,
                                                                                 vertical: OneArrange.AxisLocation.center)), height: 50, separator: SeparatorLine(position: .top,
                                                                                                                                                                  margin: (0,0),
                                                                                                                                                                  height: 0.5))
            actionItem.orderContent = orderContent
            source.append(actionItem)
        default:
            break
        }
        
        return source
    }
    
}

