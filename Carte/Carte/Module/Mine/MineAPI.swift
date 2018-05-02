//
//  MineApi.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/2.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

enum MineApi {
    case info(Int)
}

extension MineApi: TargetType {
    
    var path: String {
        switch self {
        case .info(let id):
            return "api/user/\(id)"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .info:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}
