//
//  Cart.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/7.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Unbox

struct Cart: Unboxable, DictionaryConvertible {
    
    let goodsId: Int?
    let id: Int?
    var quantity: Int?
    let userId: Int?
    
    init(id: Int? = nil, goodsId: Int, userId: Int, quantity: Int) {
        self.id = id
        self.goodsId = goodsId
        self.quantity = quantity
        self.userId = userId
    }
    
    
    init(unboxer: Unboxer) throws {
        goodsId = unboxer.unbox(key: "goodsId")
        id = unboxer.unbox(key: "id")
        quantity = unboxer.unbox(key: "quantity")
        userId = unboxer.unbox(key: "userId")
    }
    
}
