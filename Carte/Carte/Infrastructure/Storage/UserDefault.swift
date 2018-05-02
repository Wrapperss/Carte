
//
//  UserDefault.swift
//  creams
//
//  Created by Jahov on 28/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import Foundation

struct Default {
    
    struct Account: IntegerDefaultSettable {
        
        enum IntegerKey: String {
            case userId
        }
        
    }
    
    struct Flag: BoolDefaultSettable {
        
        enum BoolKey: String {
            case responseLoggerSwitch
        }
    }
}
