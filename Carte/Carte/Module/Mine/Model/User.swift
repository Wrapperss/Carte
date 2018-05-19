//
//  User.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

import Foundation
import Unbox

struct User: Unboxable, DictionaryConvertible {
    
    var balance: Double?
    let createdAt: String?
    var email: String?
    let id: Int?
    let mobile: String?
    var name: String?
    let password: String?
    let portrait: String?
    let token: String?
    let updatedAt: String?
    
    
    init(id: Int? = nil, balance: Double?, createdAt: String?, email: String?, mobile: String?, password: String?, portrait: String?, token: String?, updatedAt: String?, name: String?) {
        self.id = id
        self.balance = balance
        self.createdAt = createdAt
        self.email = email
        self.mobile = mobile
        self.password = password
        self.portrait = portrait
        self.token = token
        self.updatedAt = updatedAt
        self.name = name
    }
    
    init(unboxer: Unboxer) throws {
        balance = unboxer.unbox(key: "balance")
        createdAt = unboxer.unbox(key: "created_at")
        email = unboxer.unbox(key: "email")
        id = unboxer.unbox(key: "id")
        mobile = unboxer.unbox(key: "mobile")
        name = unboxer.unbox(key: "name")
        password = unboxer.unbox(key: "password")
        portrait = unboxer.unbox(key: "portrait")
        token = unboxer.unbox(key: "token")
        updatedAt = unboxer.unbox(key: "updated_at")
    }
    
}
