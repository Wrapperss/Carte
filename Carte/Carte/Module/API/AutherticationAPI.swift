//
//  AutherticationAPI.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/12.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import PromiseKit
import Moya

enum AutherticationAPI {
    case login(String, String)
    case regist(User)
}

extension AutherticationAPI: TargetType {
    var path: String {
        switch self {
        case .login(let mobile, let password):
            return "api/login/\(mobile)/\(password)"
        case .regist:
            return "api/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .get
        case .regist:
            return .post    
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .regist(let user):
            return user.toDictionary()
        default:
            return nil
        }
    }
}

extension AutherticationAPI {
    static func userLogin(mobile: String, password: String) -> Promise<User> {
        return Request<AutherticationAPI>().request(.login(mobile, password))
    }
    
    static func userRegist(_ user: User) -> Promise<Int> {
        return Request<AutherticationAPI>().requestPlainData(.regist(user))
    }
}
