//
//  HomeAPI.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/11.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import PromiseKit
import Moya

enum HomeAPI {
    case home
}

extension HomeAPI: TargetType {
    var path: String {
        switch self {
        case .home:
            return "api/home"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .home:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}

extension HomeAPI {
    static func fetchHome() -> Promise<HomeModel> {
        return Request<HomeAPI>().request(.home)
    }
}
