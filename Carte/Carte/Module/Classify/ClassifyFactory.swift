//
//  ClassifyFactory.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

extension DataFactory.viewRequired {
    public static func matchSortTitleCellRequired() -> [SortTitleCellRequired] {
        return [
                SortTitleCellRequired(title: "热门"),
                SortTitleCellRequired(title: "新鲜水果"),
                SortTitleCellRequired(title: "蔬菜净菜"),
                SortTitleCellRequired(title: "新鲜水产"),
                SortTitleCellRequired(title: "肉禽蛋品"),
                SortTitleCellRequired(title: "冷冻冷藏"),
                SortTitleCellRequired(title: "乳制品"),
                SortTitleCellRequired(title: "餐饮烘焙"),
                SortTitleCellRequired(title: "烹饪快手"),
                SortTitleCellRequired(title: "粮油副食"),
                SortTitleCellRequired(title: "休闲零售"),
                SortTitleCellRequired(title: "酒水饮料"),
                SortTitleCellRequired(title: "厨卫百货")
                ]
    }
}

extension DataFactory.sectionItem {
    
}
