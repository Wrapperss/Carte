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
    
    let balance : Double?
    var email : String?
    let id : Int?
    let mobile : String?
    var name : String?
    let password : String?
    
    
    init(unboxer: Unboxer) throws {
        balance = unboxer.unbox(key: "balance")
        email = unboxer.unbox(key: "email")
        id = unboxer.unbox(key: "id")
        mobile = unboxer.unbox(key: "mobile")
        name = unboxer.unbox(key: "name")
        password = unboxer.unbox(key: "password")
    }
    
}
