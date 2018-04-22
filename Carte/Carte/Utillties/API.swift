//
//  API.swift
//  creams
//
//  Created by hasayakey on 8/14/17.
//  Copyright © 2017 Creams.io. All rights reserved.
//

import Moya

extension RequestTargetType {

    var baseURL: URL {
        return URL(string: Constants.APIKey.serverURL)!
    }

    var task: Task {
        if parameters != nil {
            switch method {
            case .get:
                return .requestParameters(parameters: parameters!, encoding: URLEncoding.default)
            default:
                return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
            }
        }
        return .requestPlain
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    var validate: Bool {
        return false
    }

    var headers: [String: String]? {
        return nil
    }

    var shouldAuthorize: Bool {
        return true
    }

    var cachePolicy: RequestCachePolicy {
        return .none
    }
}
