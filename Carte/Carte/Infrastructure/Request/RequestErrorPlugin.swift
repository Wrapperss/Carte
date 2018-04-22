//
//  RequestErrorPlugin.swift
//  CreamsAgent
//
//  Created by hasayakey on 20/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Moya
import Result

public enum RequestError: Swift.Error {

    case unkonwn

    case statusCode(Int, String)

    case jsonMapping(String)

    case imageMapping(String)

    case stringMapping(String)

    case underlying(Swift.Error, Moya.Response?)

    case requestMapping(String)
}

extension RequestError: LocalizedError {

    public var errorDescription: String {
        switch self {
        case .unkonwn:
            return "服务器休息了\n程序员GG正在拼命修复中…"
        case .statusCode( _, let info):
            return info
        case .jsonMapping(let info):
            return info
        case .imageMapping(let info):
            return info
        case .stringMapping(let info):
            return info
        case .underlying(let error, _):
            return error.localizedDescription
        case .requestMapping(let info):
            return info
        }
    }

    public var message: String {
        switch self {
        case .unkonwn:
            return "服务器休息了\n程序员GG正在拼命修复中…"
        case .statusCode(let code, let info):
            switch code {
            case 404, 500, 502, 504:
                return "服务器休息了\n程序员GG正在拼命修复中…"
            default:
                return info
            }
        case .jsonMapping(let info):
            return info
        case .imageMapping(let info):
            return info
        case .stringMapping(let info):
            return info
        case .underlying(let error, _):
            let systemError = error as NSError
            if systemError.code <= -1_001 && systemError.code >= -1_009 {
                return "网络貌似断开了"
            } else {
                return error.localizedDescription
            }
        case .requestMapping(let info):
            return info
        }
    }
}

public protocol RequestErrorPluginStaticFetchable {
    var errorPlugin: RequestErrorPlugin { get }
}

extension RequestErrorPluginStaticFetchable {
    public var errorPlugin: RequestErrorPlugin {
        return RequestErrorPlugin.default
    }
}

/// 转化所有请求的错误为自定义错误
public final class RequestErrorPlugin: PluginType {

    fileprivate static let `default`: RequestErrorPlugin = {
        return RequestErrorPlugin()
    }()

    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {

        switch result {
        case .success(let response):

            guard response.statusCode >= 200, response.statusCode <= 299 else {

                do {
                    let data = try response.mapJSON()

                    guard let errorInfo = (data as? [String: Any])?["error"] as? String else {
                        let internalError = RequestError.unkonwn
                        let error = MoyaError.underlying(internalError, response)
                        return Result(error: error)
                    }

                    let internalError = RequestError.statusCode(response.statusCode, errorInfo)
                    let error = MoyaError.underlying(internalError, nil)
                    return Result(error: error)
                } catch {
                    return Result(error: MoyaError.underlying(RequestError.jsonMapping(error.localizedDescription), response))
                }
            }

            return result

        case .failure(let error):
            switch error {
            case .imageMapping(_):
                return Result(error: MoyaError.underlying(RequestError.imageMapping("服务器休息了\n程序员GG正在拼命修复中…"), nil))
            case .jsonMapping(_):
                return Result(error: MoyaError.underlying(RequestError.jsonMapping("服务器休息了\n程序员GG正在拼命修复中…"), nil))
            case .stringMapping(_):
                return Result(error: MoyaError.underlying(RequestError.stringMapping("服务器休息了\n程序员GG正在拼命修复中…"), nil))
            case .statusCode(let response):
                return Result(error: MoyaError.underlying(RequestError.statusCode(response.statusCode, "错误\(response.statusCode)"), nil))
            case .underlying(let error, let response):
                return Result(error: MoyaError.underlying(RequestError.underlying(error, response), nil))
            case .requestMapping(let info):
                return Result(error: MoyaError.underlying(RequestError.requestMapping(info), nil))
            }
        }
    }

}

/*
 kCFURLErrorUnknown   = -998,
 kCFURLErrorCancelled = -999,
 kCFURLErrorBadURL    = -1000,
 kCFURLErrorTimedOut  = -1001,
 kCFURLErrorUnsupportedURL = -1002,
 kCFURLErrorCannotFindHost = -1003,
 kCFURLErrorCannotConnectToHost    = -1004,
 kCFURLErrorNetworkConnectionLost  = -1005,
 kCFURLErrorDNSLookupFailed        = -1006,
 kCFURLErrorHTTPTooManyRedirects   = -1007,
 kCFURLErrorResourceUnavailable    = -1008,
 kCFURLErrorNotConnectedToInternet = -1009,
 kCFURLErrorRedirectToNonExistentLocation = -1010,
 kCFURLErrorBadServerResponse             = -1011,
 kCFURLErrorUserCancelledAuthentication   = -1012,
 kCFURLErrorUserAuthenticationRequired    = -1013,
 kCFURLErrorZeroByteResource        = -1014,
 kCFURLErrorCannotDecodeRawData     = -1015,
 kCFURLErrorCannotDecodeContentData = -1016,
 kCFURLErrorCannotParseResponse     = -1017,
 kCFURLErrorInternationalRoamingOff = -1018,
 kCFURLErrorCallIsActive               = -1019,
 kCFURLErrorDataNotAllowed             = -1020,
 kCFURLErrorRequestBodyStreamExhausted = -1021,
 kCFURLErrorFileDoesNotExist           = -1100,
 kCFURLErrorFileIsDirectory            = -1101,
 kCFURLErrorNoPermissionsToReadFile    = -1102,
 kCFURLErrorDataLengthExceedsMaximum   = -1103,
 */
