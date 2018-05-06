//
//  CollectionAPI.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/6.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

enum CollectionAPI {
    case collectGoods(Int ,Int)
    case cancelCollectGoods(Int, Int)
    case isCollectGoods(Int, Int)
    case didCollectGoods(Int)
}

extension CollectionAPI: TargetType {
    var path: String {
        switch self {
        case .collectGoods:
            return "api/collection"
        case .cancelCollectGoods(let userId, let goodsId):
            return "api/collection/\(userId)/\(goodsId)"
        case .isCollectGoods(let userId, let goodsId):
            return "/api/collection/\(userId)/\(goodsId)"
        case .didCollectGoods(let goodsId):
            return "api/collection/\(goodsId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .collectGoods:
            return .post
        case .cancelCollectGoods:
            return .delete
        default:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .collectGoods(let userId, let goodsId):
            let dic: [String: Int] = ["userId": userId, "goodsId": goodsId]
            return dic
        default:
            return nil
        }
    }
}

extension CollectionAPI {
    static func postCollectGoods(userId: Int, goodsId: Int) -> Promise<BlankResponse> {
        return Request<CollectionAPI>().request(.collectGoods(userId, goodsId))
    }
    
    static func deleteCollectGoods(userId: Int, goodsId: Int) -> Promise<BlankResponse> {
        return Request<CollectionAPI>().request(.cancelCollectGoods(userId, goodsId))
    }
    
    static func fetchIsCollectGoods(userId: Int, goodsId: Int) -> Promise<Collection> {
        return Request<CollectionAPI>().request(.isCollectGoods(userId, goodsId))
    }
    
    static func fetchCollectGoods(userId: Int) -> Promise<[Goods]> {
        return Request<CollectionAPI>().request(.didCollectGoods(userId))
    }
}
