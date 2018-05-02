//
//  API.swift
//  CreamsAgent
//
//  Created by hasayakey on 20/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import Moya
import Unbox

extension TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.APIKey.serverURL)!
    }
    
    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
        // return URLEncoding(destination: .queryString)
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var validate: Bool {
        return false
    }
    
    
}

extension AccessTokenAuthorizable {
    
    var shouldAuthorize: Bool {
        return true
    }
    
}
