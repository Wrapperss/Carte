//
//  Typealias.swift
//  creams
//
//  Created by hasayakey on 8/9/17.
//  Copyright © 2017 Creams.io. All rights reserved.
//

import Foundation

typealias ID = Int
typealias Index = Int

let PageSize: Int = 100
let emptyContent: String = "暂无"
let emptyString: String = ""
let numberEmptyContent: String = "-"

enum PageIndex {
    case all
    case index(Int)

    var value: Int {
        switch self {
        case .index(let pageIndex):
            return pageIndex
        default:
            return 1
        }
    }
}

/// 定义数据刷新类型
enum LoadType {
    case load
    case refresh
    case loadMore
}

/// 定义数据刷新类型的存储类型
typealias LoadState = [LoadType: Bool]

//定义一次上拉刷新状态: value - 是不是正在上拉刷新; nomore - 是不是已加载全部数据
typealias LoadMore = (value: Bool, nomore: Bool)
