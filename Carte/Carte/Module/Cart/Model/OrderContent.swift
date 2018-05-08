//
//  OrderContent.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Unbox

struct OrderContent: Unboxable {
    
    struct Order: Unboxable, DictionaryConvertible {
        
        let amount: Int?
        let createDate: String?
        let dealDate: String?
        let fare: Int?
        let id: Int?
        let numbering: String?
        let payDate: String?
        let payment: Int?
        let shipDate: String?
        let status: String?
        let userId: Int?
        
        
        init(unboxer: Unboxer) throws {
            amount = unboxer.unbox(key: "amount")
            createDate = unboxer.unbox(key: "createDate")
            dealDate = unboxer.unbox(key: "dealDate")
            fare = unboxer.unbox(key: "fare")
            id = unboxer.unbox(key: "id")
            numbering = unboxer.unbox(key: "numbering")
            payDate = unboxer.unbox(key: "payDate")
            payment = unboxer.unbox(key: "payment")
            shipDate = unboxer.unbox(key: "shipDate")
            status = unboxer.unbox(key: "status")
            userId = unboxer.unbox(key: "userId")
        }
        
    }
    
    struct OrderGoods: Unboxable {
        
        let goodsId: Int?
        let id: Int?
        let orderId: Int?
        let quantity: Int?
        
        
        init(unboxer: Unboxer) throws {
            goodsId = unboxer.unbox(key: "goodsId")
            id = unboxer.unbox(key: "id")
            orderId = unboxer.unbox(key: "orderId")
            quantity = unboxer.unbox(key: "quantity")
        }
        
    }
    
    let orderGoods: [OrderGoods]?
    let order: Order?
    
    
    init(unboxer: Unboxer) throws {
        orderGoods = unboxer.unbox(key: "OrderGoods")
        order = unboxer.unbox(key: "order")
    }
    
}
