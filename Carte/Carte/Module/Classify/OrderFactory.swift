//
//  OrderFactory.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

extension DataFactory.viewRequired {
    fileprivate static func matchOrderAdressCellRequired(_ address: Address) -> OrderAdressCellRequired {
        return OrderAdressCellRequired(name: "收货人：\(address.contract ?? "-")",
                                       address: "\(address.city ?? "")\(address.detail ?? "")",
                                       phone: address.phoneNum ?? "")
    }
}

extension DataFactory.sectionItem {

    public static func prepareOrderConfirmSoure(address: Address, cartMsg: [(cart: Cart, goods: Goods)]) -> [ListDiffable] {
        var source = [ListDiffable]()
        let addressItem = OrderAdressSectionItem(data: DataFactory.viewRequired.matchOrderAdressCellRequired(address))
        source.append(addressItem)
        
        let cartItems = cartMsg.flatMap {
            [
                FormItem(elements: [TextElement(text: NSAttributedString.attribute("包裹", .black, fontSize: 15))],
                         arrange: OneArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                             location: OneArrange.AxisLocation.leading(20)),
                         height: 50,
                         separator: SeparatorLine(position: .bottom, margin: (20, 0), height: 0.5)),
                
                FormItem(elements: [TextElement(text: NSAttributedString.attribute($0.goods.name ?? "", .black, fontSize: 15)),
                                TextElement(text: NSAttributedString.attribute("\($0.goods.price ?? 0.0)元 * \($0.cart.quantity ?? 1)", .black, fontSize: 15))],
                     arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                         location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding,
                                                                                 spaces: (first: 20, last: 20))),
                     height: 80,
                     separator: SeparatorLine(position: .bottom, margin: (20, 0), height: 0.5)),
                FormItem(elements: [TextElement(text: NSAttributedString.attribute("邮费", .black, fontSize: 15)),
                                    TextElement(text: NSAttributedString.attribute("\($0.goods.postage ?? 0.0)元", .black, fontSize: 15))],
                         arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                             location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding,
                                                                                     spaces: (first: 20, last: 20))),
                         height: 50,
                         separator: SeparatorLine(position: .bottom, margin: (20, 0), height: 0.5))
            ]
        }
        source.append(contentsOf: cartItems)
        
        source.append(FormItem.blank(height: 10, backgroundColor: .backgroundColor))
        
        let messageItem = FormItem(elements: [TextElement(text: NSAttributedString.attribute("买家留言", .black, fontSize: 15)),
                                              TextFieldElement(holder: "如有特殊配送要求，请在此填写附言")],
                                   arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                                       location: TwoArrange.Location.spacing(style: TwoArrange.Location.SpacingRefStyle.leading,
                                                                                             spaces: (first: 20, last: 100))),
                                   height: 50,
                                   separator: SeparatorLine(position: .bottom, margin: (20, 0), height: 0.5))
        source.append(messageItem)
        
        let blankItem  = FormItem.blank(height: 10, backgroundColor: .backgroundColor)
        source.append(blankItem)
        
        var allPostage: Double = 0.0
        var allCost: Double = 0.0
        for msg in cartMsg {
            allPostage = allPostage + (msg.goods.postage ?? 0.0)
            allCost = allCost + Double(msg.cart.quantity ?? 0) * (msg.goods.price ?? 0.0)
        }
        
        
        let postageItem = FormItem(elements: [TextElement(text: NSAttributedString.attribute("总邮费", .black, fontSize: 15)),
                                              TextElement(text: NSAttributedString.attribute("\(allPostage)元", UIColor(r: 255, g: 57, b: 57), fontSize: 15))],
                                   arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                                       location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding,
                                                                                               spaces: (first: 20, last: 20))),
                                   height: 50,
                                   separator: SeparatorLine(position: .bottom, margin: (20, 0), height: 0.5))
        source.append(postageItem)
        
        let priceItem = FormItem(elements: [TextElement(text: NSAttributedString.attribute("商品总价", .black, fontSize: 15)),
                                            TextElement(text: NSAttributedString.attribute("\(allCost)元", UIColor(r: 255, g: 57, b: 57), fontSize: 15))],
                                 arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                                     location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding,
                                                                                             spaces: (first: 20, last: 20))),
                                 height: 50,
                                 separator: SeparatorLine(position: .bottom, margin: (20, 0), height: 0.5))
        
        source.append(priceItem)
        
        return source
    }
}
