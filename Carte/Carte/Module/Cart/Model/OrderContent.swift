//
//  OrderContent.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Unbox

struct OrderContent: Unboxable, DictionaryConvertible {
    
    struct Order: Unboxable, DictionaryConvertible {
        
        let amount: Double?
        let createDate: String?
        let dealDate: String?
        let fare: Double?
        let id: Int?
        let payDate: String?
        let payment: Double?
        let shipDate: String?
        let status: String?
        let userId: Int?
        
        init(id: Int? = nil, userId: Int, amount: Double, fare: Double, payment: Double, createDate: String, status: String = "待付款", dealDate: String? = nil, payDate: String? = nil, shipDate: String? = nil) {
            self.id = id
            self.userId = userId
            self.amount = amount
            self.fare = fare
            self.payment = payment
            self.createDate = createDate
            self.status = status
            self.dealDate = dealDate
            self.payDate = payDate
            self.shipDate = shipDate
        }
        
        init(unboxer: Unboxer) throws {
            amount = unboxer.unbox(key: "amount")
            createDate = unboxer.unbox(key: "createDate")
            dealDate = unboxer.unbox(key: "dealDate")
            fare = unboxer.unbox(key: "fare")
            id = unboxer.unbox(key: "id")
            payDate = unboxer.unbox(key: "payDate")
            payment = unboxer.unbox(key: "payment")
            shipDate = unboxer.unbox(key: "shipDate")
            status = unboxer.unbox(key: "status")
            userId = unboxer.unbox(key: "userId")
        }
        
    }
    
    struct OrderGoods: Unboxable, DictionaryConvertible {
        
        let goodsId: Int?
        let id: Int?
        let orderId: Int?
        let quantity: Int?
        
        init(id: Int? = nil, goodsId: Int, orderId: Int? = nil, quantity: Int) {
            self.id = id
            self.goodsId = goodsId
            self.orderId = orderId
            self.quantity = quantity
        }
        
        init(unboxer: Unboxer) throws {
            goodsId = unboxer.unbox(key: "goodsId")
            id = unboxer.unbox(key: "id")
            orderId = unboxer.unbox(key: "orderId")
            quantity = unboxer.unbox(key: "quantity")
        }
        
    }
    
    let orderGoods: [OrderGoods]?
    let order: Order?
    
    init(orderGoods: [OrderGoods], order: Order) {
        self.order = order
        self.orderGoods = orderGoods
    }
    
    
    init(unboxer: Unboxer) throws {
        orderGoods = unboxer.unbox(key: "OrderGoods")
        order = unboxer.unbox(key: "order")
    }
    
}
