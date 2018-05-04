//
//  ClassifyAPI.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/3.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

enum ClassifyAPI {
    case allCategory
    case goodsInCategory(Int)
}


extension ClassifyAPI: TargetType {
    var path: String {
        switch self {
        case .allCategory:
            return "api/category"
        case .goodsInCategory(let categoryId):
            return "api/goods/category/\(categoryId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .allCategory, .goodsInCategory:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .allCategory, .goodsInCategory:
            return nil
        }
    }
}


extension ClassifyAPI {
    static func fetchAllCategory() -> Promise<[Category]> {
        return Request<ClassifyAPI>().requestList(.allCategory)
    }
    
    static func fetchGoodsInCategory(_ categoyrId: Int) -> Promise<[Goods]> {
        return Request<ClassifyAPI>().requestList(.goodsInCategory(categoyrId))
    }
}
