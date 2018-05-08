//
//  OrderAPI.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

enum OrderAPI {
    case create(OrderContent.Order)
    case update(Int, OrderContent.Order)
    case usersOrder(Int)
}

extension OrderAPI: TargetType {
    var path: String {
        switch self {
        case .create:
            return "api/order"
        case .update(let orderId, _):
            return "api/order/\(orderId)"
        case .usersOrder(let userId):
            return "api/order/user/\(userId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .update:
            return .put
        case .usersOrder:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .create(let order):
            return order.toDictionary()
        case .update(_, let order):
            return order.toDictionary()
        case .usersOrder:
            return nil
        }
    }
}

extension OrderAPI {
    static func postOrder(_ order: OrderContent.Order) -> Promise<BlankResponse> {
        return Request<OrderAPI>().request(.create(order))
    }
    
    static func updateOrder(orderId: Int, order: OrderContent.Order) -> Promise<BlankResponse> {
        return Request<OrderAPI>().request(.update(orderId, order))
    }
    
    static func fetchUserOrder(_ userId: Int) -> Promise<[OrderContent]> {
        return Request<OrderAPI>().requestList(.usersOrder(userId))
    }
}
