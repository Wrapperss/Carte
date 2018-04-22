
//
//  UserDefault.swift
//  creams
//
//  Created by Jahov on 28/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import Foundation

struct Default {
    
    struct Account: StringDefaultSettable, BoolDefaultSettable, IntegerDefaultSettable {
        
        enum StringKey: String {
            case lastLoginUserName
        }
        
        enum BoolKey: String {
            case firstLoginConfig
        }
        
        enum IntegerKey: String {
            case iconBadge
        }
        
    }
    
    struct Flag: BoolDefaultSettable {
        
        enum BoolKey: String {
            case responseLoggerSwitch
        }
    }
}
