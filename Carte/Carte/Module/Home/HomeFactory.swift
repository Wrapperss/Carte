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
}

extension DataFactory.sectionItem {
    public static func prepareHomeCategoarySectionItem(_ categpry: Category) -> HomeCategoarySectionItem {
        return HomeCategoarySectionItem(data: DataFactory.viewRequired.matchHomeCategoaryCellRequired(categpry), category: categpry)
    }
}
