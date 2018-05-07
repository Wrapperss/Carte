//
//  CartFactory.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

extension DataFactory.viewRequired {
    static func matchCommodityCellRequired(goods: Goods, cart: Cart) -> CommodityCellRequired {
        return CommodityCellRequired(title: goods.name ?? "",
                                     description: goods.descriptionField ?? "",
                                     price: "单价 \(goods.price ?? 0.0)元", count: "\(cart.quantity ?? 1)",
                                     imageUrl: goods.picture ?? "")
    }
}

extension DataFactory.sectionItem {
    static func prepareCommoditySectionItem(_ requireds: [Cart]) -> [CommoditySectionItem] {
        return requireds.map { CommoditySectionItem.init(data: $0) }
    }
}

