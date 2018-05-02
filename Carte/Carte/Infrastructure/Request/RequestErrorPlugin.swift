//
//  RequestErrorPlugin.swift
//  CreamsAgent
//
//  Created by hasayakey on 20/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Result
import Moya
import Foundation

public typealias RequestComplection = (_ result: Result<Moya.Response, MoyaError>) -> Void

enum RequestError: Swift.Error {
    case unkonwn
    case statusCode(Int, String)
    case jsonMapError
}

extension RequestError: LocalizedError {
    public var errorDescription: String {
        switch self {
        case .unkonwn:
            return "服务器发生内部错误"
        case .statusCode(let code, let info):
            switch code {
                //            case 400:
                //                return "无法解析你所提交的数据(\(info))"
                //            case 401:
                //                return "无权限操作该接口(\(info))"
                //            case 404:
                //                return "你所请求的接口或资源不存在(\(info))"
                //            case 415:
                //                return "请求头中缺少ContentType(\(info))"
                //            case 422:
            //                return "修改或创建一个资源时发生一个验证错误(\(info))"
            default:
                return info
            }
        case .jsonMapError:
            return "接受数据发生格式化错误"
        }
    }
}

protocol ErrorShowProtocol {
    func showHUD()
}

extension Swift.Error {
    
    func showHUD() {
        if let requestError = self as? RequestError {
            requestError.showHUD()
        } else if let moyaError = self as? MoyaError {
            moyaError.showHUD()
        }
    }
}

extension RequestError: ErrorShowProtocol {
    
    func showHUD() {
        switch self {
        case .statusCode(_, let error):
            HUD.showError(error)
        default :
            HUD.showError(self.errorDescription)
        }
    }
}

extension MoyaError: ErrorShowProtocol {
    
    func showHUD() {
        switch self {
        case .underlying(let error):
            if let requestError =  error as? RequestError {
                if case let .statusCode(code, errorstr) = requestError, code == 401, errorstr == "invalid_token" {
                    DispatchQueue.main.async {
                        Delay(time: 0.1, task: {
                            HUD.showError("登录信息已过期, 请重新登录")
//                            LoginViewController.show()
                        })
                    }
                    return
                }
                HUD.showError((error as! RequestError).errorDescription)
            } else {
                HUD.showError(error.localizedDescription)
            }
        default :
            HUD.showError(self.errorDescription!)
        }
    }
}

/// 转化常规的错误
public final class RequestErrorPlugin: PluginType {
    
    static var `default`: RequestErrorPlugin = {
        return RequestErrorPlugin()
    }()
    
    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
        
        if case .success(let response) = result {
            
            guard response.statusCode >= 200, response.statusCode <= 299 else {
                
                do {
                    let data = try response.mapJSON()
                    
                    guard let errorInfo = (data as? [String: Any])?["error"] as? String else {
                        let internalError = RequestError.unkonwn
                        let error = MoyaError.underlying(internalError)
                        return Result(error: error)
                    }
                    
                    let internalError = RequestError.statusCode(response.statusCode, errorInfo)
                    let error = MoyaError.underlying(internalError)
                    return Result(error: error)
                    
                } catch {
                    debugPrint("Http请求在输出内置错误的时候发生错误：\(error)")
                }
                
                return result
            }
            
            return result
        }
        
        return result
    }
    
}
