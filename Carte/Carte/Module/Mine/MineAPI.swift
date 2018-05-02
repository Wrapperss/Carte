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

enum MineAPI {
    case info(Int)
    case updateInfo(User)
}

extension MineAPI: TargetType {
    
    var path: String {
        switch self {
        case .info(let id):
            return "api/users/\(id)"
        case .updateInfo(let user):
            return "api/users/\(user.id ?? 0)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .info:
            return .get
        case .updateInfo:
            return .put
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .updateInfo(let user):
            return user.toDictionary()
        default:
            return nil
        }
    }
}


extension MineAPI {
    static func fetchUserInfo(_ userId: Int) -> Promise<User> {
        return Request<MineAPI>().request(.info(userId))
    }
    
    static func updateUserInfo(_ user: User) -> Promise<BlankResponse> {
        return  Request<MineAPI>().request(.updateInfo(user))
    }
}
