//
//  CartAPI.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/7.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

enum CartAPI {
    case showUserCart(Int)
    case create(Cart)
    case remove(Int)
    case update(Int, Cart)
}

extension CartAPI: TargetType {
    var path: String {
        switch self {
        case .showUserCart(let userId):
            return "api/cart/user/\(userId)"
        case .create:
            return "api/cart"
        case .remove(let cartId):
            return "api/cart/\(cartId)"
        case .update(let cartId, _):
            return "api/cart/\(cartId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .update:
            return  .put
        case .remove:
            return .delete
        default:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .create(let cart):
            return cart.toDictionary()
        case .update(_, let cart):
            return cart.toDictionary()
        default:
            return nil
        }
    }
}

extension CartAPI {
    static func fetchUserCart(userId: Int) -> Promise<[Cart]> {
        return Request<CartAPI>().requestList(.showUserCart(userId))
    }
    
    static func addCart(_ cart: Cart) -> Promise<BlankResponse> {
        return Request<CartAPI>().request(.create(cart))
    }
    
    static func removeCart(_ cartId: Int) -> Promise<BlankResponse> {
        return Request<CartAPI>().request(.remove(cartId))
    }
    
    static func updateCart(cartId: Int, cart: Cart) -> Promise<BlankResponse> {
        return Request<CartAPI>().request(.update(cartId, cart))
    }
}
