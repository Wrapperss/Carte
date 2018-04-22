//
//  AuthorizationPlugin.swift
//  CreamsAgent
//
//  Created by hasayakey on 20/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Result
import Moya
import Foundation

public typealias RequestResponse = Moya.Response

public protocol AccessTokenAuthorizable {
    var shouldAuthorize: Bool { get }
}

public protocol RequestAuthorizationPluginStaticFetchable {
    var authorizationPlugin: RequestAuthorizationPlugin { get }
}

protocol RequestAuthorizationPluginUpdate {
    func updatePlugin(token: String?)
}

/// 外部处理认证失败的协议
protocol RequestUnAuthorisedProcess: NSObjectProtocol {
    func register(processer: RequestUnAuthorisedProcess)
    func processUnAuthorisedResponse(_ response: RequestResponse) -> Result<Moya.Response, MoyaError>?
}

/// 提供默认实现方法

extension RequestAuthorizationPluginStaticFetchable {
    public var authorizationPlugin: RequestAuthorizationPlugin {
        return RequestAuthorizationPlugin.default
    }
}

extension RequestAuthorizationPluginUpdate {

    func updatePlugin(token: String?) {
        if let token = token {
            RequestAuthorizationPlugin.default.token = tokenPrefix + token
        } else {
            RequestAuthorizationPlugin.default.token = nil
        }
    }
}

extension RequestUnAuthorisedProcess {

    func register(processer: RequestUnAuthorisedProcess) {
        RequestAuthorizationPlugin.default.unAuthorisedProcesser = processer
    }
}

/// 负责http的验证以及处理http无权限的问题（Authorization过期或非法）
public final class RequestAuthorizationPlugin: PluginType {

    fileprivate static let `default`: RequestAuthorizationPlugin = {
        return RequestAuthorizationPlugin()
    }()

    fileprivate weak var unAuthorisedProcesser: RequestUnAuthorisedProcess?
    fileprivate var token: String?

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue("\(version)", forHTTPHeaderField: "User-Agent")

        guard let authorizable = target as? AccessTokenAuthorizable,
            authorizable.shouldAuthorize == true,
            let authVal = token else {
            return request
        }
        request.addValue(authVal, forHTTPHeaderField: "Authorization")

        return request
    }

    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {

        if case .success(let response) = result {
            if response.statusCode == 401, let processer = unAuthorisedProcesser {
                if let _result = processer.processUnAuthorisedResponse(response), token != nil {
                    return _result
                }
                return result
            }
            return result
        }

        return result
    }
}

private let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
private let tokenPrefix: String = "Bearer "
