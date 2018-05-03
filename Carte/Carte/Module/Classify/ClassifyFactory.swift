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
            .map { SortTitleCellRequired.init(title: $0.name ?? "-") }
    }
}

extension DataFactory.sectionItem {
    
}
