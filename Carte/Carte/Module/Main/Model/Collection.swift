//
//  Collection.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/6.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Unbox

struct Collection: Unboxable {
    
    let goodsId: Int?
    let id: Int?
    let userId: Int?
    
    
    init(unboxer: Unboxer) throws {
        goodsId = unboxer.unbox(key: "goodsId")
        id = unboxer.unbox(key: "id")
        userId = unboxer.unbox(key: "userId")
    }
    
}
