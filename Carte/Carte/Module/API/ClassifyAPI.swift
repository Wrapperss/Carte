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
    case goodsInCategoryByVolume(Int)
    case goodsInCategoryByPrice(Int)
    case goodDetail(Int)
    case categoryDetail(Int)
}


extension ClassifyAPI: TargetType {
    var path: String {
        switch self {
        case .allCategory:
            return "api/category"
        case .goodsInCategory(let categoryId):
            return "api/goods/category/\(categoryId)"
        case .goodsInCategoryByPrice(let categoryId):
            return "api/goods/category/price/\(categoryId)"
        case .goodsInCategoryByVolume(let categoryId):
            return "api/goods/category/volume/\(categoryId)"
        case .goodDetail(let goodsId):
            return "api/goods/\(goodsId)"
        case .categoryDetail(let id):
            return "api/category/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        default:
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
    
    static func fetchGoodsInCategoryByVolume(_ categoyrId: Int) -> Promise<[Goods]> {
        return Request<ClassifyAPI>().requestList(.goodsInCategoryByVolume(categoyrId))
    }
    
    static func fetchGoodsInCategoryByPrice(_ categoyrId: Int) -> Promise<[Goods]> {
        return Request<ClassifyAPI>().requestList(.goodsInCategoryByPrice(categoyrId))
    }
    
    static func fetchGoodsDetail(_ goodsId: Int) -> Promise<Goods> {
        return Request<ClassifyAPI>().request(.goodDetail(goodsId))
    }
    
    static func fetchCategoryDetail(_ categoryId: Int) -> Promise<Category> {
        return Request<ClassifyAPI>().request(.categoryDetail(categoryId))
    }
}
