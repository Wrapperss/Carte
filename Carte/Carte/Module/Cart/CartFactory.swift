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
    
}

extension DataFactory.sectionItem {
    static func prepareCommoditySectionItem() -> [CommoditySectionItem] {
        return [CommoditySectionItem(data: CommodityCellRequired(title: "牛很鲜潮汕牛肉火锅", description: "类型：双人餐", price: "单价：155元", count: "1", imageUrl: ""))]
    }
}

