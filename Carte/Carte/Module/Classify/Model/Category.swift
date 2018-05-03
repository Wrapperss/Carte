//
//  Category.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/3.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Unbox

struct Category: Unboxable {
    let id : Int?
    let name : String?
    let superCategory : Int?
    let cover: String?
    
    init(unboxer: Unboxer) throws {
        id = unboxer.unbox(key: "id")
        name = unboxer.unbox(key: "name")
        superCategory = unboxer.unbox(key: "superCategory")
        cover = unboxer.unbox(key: "cover")
    }
}
