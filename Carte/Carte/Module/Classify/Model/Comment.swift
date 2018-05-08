//
//  Comment.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Unbox

struct Comment: Unboxable, DictionaryConvertible {
    
    let content: String?
    let descriptionMark: Int?
    let goodsId: Int?
    let id: Int?
    let logisticsMark: Int?
    let recommendMark: Int?
    let userId: Int?
    let userName: String?
    
    
    init(unboxer: Unboxer) throws {
        content = unboxer.unbox(key: "content")
        descriptionMark = unboxer.unbox(key: "descriptionMark")
        goodsId = unboxer.unbox(key: "goodsId")
        id = unboxer.unbox(key: "id")
        logisticsMark = unboxer.unbox(key: "logisticsMark")
        recommendMark = unboxer.unbox(key: "recommendMark")
        userId = unboxer.unbox(key: "userId")
        userName = unboxer.unbox(key: "userName")
    }
    
}
