//
//  ClassifyFactory.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

extension DataFactory.viewRequired {
    
    public static func matchSortTitleCellRequired(_ categorys: [Category]) -> [SortTitleCellRequired] {
        return categorys
            .filter { $0.superCategory == nil }
            .map { SortTitleCellRequired(title: $0.name ?? "-") }
    }
    
    public static func matchCommodityCellRequired(mainCategory: Category, allCategory: [Category]) -> CommodityContentCellRequired {
        let subItemRequireds = allCategory
            .filter { $0.superCategory ?? 0 == mainCategory.id ?? 0 }
            .map { matchCommoditySubItemCellRequired($0) }
        return CommodityContentCellRequired(title: mainCategory.name ?? "-", subItemRequireds: subItemRequireds)
    }
    
    private static func matchCommoditySubItemCellRequired(_ category: Category) -> CommoditySubItemCellRequired {
        return CommoditySubItemCellRequired(categoryId: category.id ?? 0, cover: category.cover ?? "", title: category.name ?? "")
    }
    
    public static func matchGoodsCellRequired(_ goodes: [Goods]) -> [GoodsCellRequired] {
        return goodes.map({ goods -> GoodsCellRequired in
            return GoodsCellRequired(image: goods.picture ?? "-",
                                     title: goods.name ?? "-",
                                     description: goods.descriptionField ?? "-",
                                     comment: "",
                                     price: "¥\(goods.price ?? 0.0)",
                                     orginalPrice: "¥\(goods.originalPrice ?? 0.0)",
                                     postage: "  邮费：\(goods.postage ?? 0/0)  ")
        })
    }
}

extension DataFactory.sectionItem {
    
    public static func prapareCommodityContentItem(_ required: CommodityContentCellRequired) -> CommodityContentItem {
        return CommodityContentItem(required)
    }
    
    public static func prepareGoodsItem(_ requireds: [GoodsCellRequired]) -> [GoodsSectionItem] {
        return requireds.map { GoodsSectionItem(data: $0) }
    }
}
