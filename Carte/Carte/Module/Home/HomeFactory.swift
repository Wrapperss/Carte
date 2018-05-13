//
//  HomeFactory.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/11.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

extension DataFactory.viewRequired {
    fileprivate static func matchHomeCategoaryCellRequired(_ category: Category) -> HomeCategoaryCellRequired {
        return HomeCategoaryCellRequired(title: category.name ?? "", decription: "超值活动中！！！", image: category.cover ?? "")
    }
    
    fileprivate static func matchHomeGoodsCellRequired(_ goods: Goods) -> HomeGoodsCellRequired {
        return HomeGoodsCellRequired(image: goods.picture ?? "", title: goods.name ?? "", price: "¥\(goods.price ?? 0.0)", orginPrice: "¥\(goods.originalPrice ?? 0.0)", goodsId: goods.id ?? 0)
    }
    
    fileprivate static func matchHomeSingelCellRequired(_ singleGoods: Goods) -> HomeSingelCellRequired {
        return HomeSingelCellRequired(title: "24小时热卖",
                                      des: "", iamge: singleGoods.picture ?? "",
                                      goodsName: singleGoods.name ?? "",
                                      goodsDes: singleGoods.descriptionField ?? "",
                                      goodPrice: "¥\(singleGoods.price ?? 0.0)",
                                     goodsOrginPrice: "¥\(singleGoods.originalPrice ?? 0.0)")
    }
    
}

extension DataFactory.sectionItem {
    public static func prepareHomeCategoarySectionItem(_ categpry: Category) -> HomeCategoarySectionItem {
        return HomeCategoarySectionItem(data: DataFactory.viewRequired.matchHomeCategoaryCellRequired(categpry), category: categpry)
    }
    
    public static func prepareHomeGoodsSectionItem(_ goodses: [Goods], categoryId: Int) -> HomeGoodsSectionItem {
        return HomeGoodsSectionItem.init(requireds: [
            DataFactory.viewRequired.matchHomeGoodsCellRequired(goodses.first!),
            DataFactory.viewRequired.matchHomeGoodsCellRequired(goodses.last!)],
                                         categoryId: categoryId)
    }
    
    public static func prepareHomeSingelSectionItem(_ singleGoods: Goods) -> HomeSingelSectionItem {
        return HomeSingelSectionItem.init(data: DataFactory.viewRequired.matchHomeSingelCellRequired(singleGoods), goodsId: singleGoods.id ?? 0)
    }
}
