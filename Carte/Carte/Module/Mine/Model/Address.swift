//
//  Address.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/6.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Unbox

struct Address: Unboxable, DictionaryConvertible {
    
    let city: String?
    let detail: String?
    let id: Int?
    let isDefault: Int?
    let phoneNum: String?
    let userId: Int?
    let contract: String?
    
    init(contract: String, phoneNum: String, city: String, detail: String, isDefault: Int, userId: Int) {
        self.contract = contract
        self.phoneNum = phoneNum
        self.city = city
        self.detail = detail
        self.isDefault = isDefault
        self.userId = userId
        self.id = nil
    }
    
    init(unboxer: Unboxer) throws {
        city = unboxer.unbox(key: "city")
        detail = unboxer.unbox(key: "detail")
        id = unboxer.unbox(key: "id")
        isDefault = unboxer.unbox(key: "isDefault")
        phoneNum = unboxer.unbox(key: "phoneNum")
        userId = unboxer.unbox(key: "userId")
        contract = unboxer.unbox(key: "contract")
    }
    
}
