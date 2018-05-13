//
//  HomeModel.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/11.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import Unbox

struct HomeModel: Unboxable {
    
    let category: Category?
    
    
    init(unboxer: Unboxer) throws {
        category = unboxer.unbox(key: "category")
    }
    
}