//
//  Request.swift
//  CreamsAgent
//
//  Created by hasayakey on 14/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Result
import Moya
import Unbox
import Foundation
import PromiseKit


private let sessionManager: Manager = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
    
    let manager = Manager(configuration: configuration)
    manager.startRequestsImmediately = false
    return manager
}()

class AnyCancelable: Cancellable {
    var isCancelled: Bool = false
    func cancel() {}
    init() {}
}

final class Request<Target>: MoyaProvider<Target> where Target: TargetType {
    
    public init(plugins: [PluginType] = []) {
        var extenPlugins: [PluginType] = [RequestErrorPlugin.default]
        #if DEBUG
        extenPlugins.append(RequestLoggerPlugin(verbose: true))
        #endif
        super.init(manager: sessionManager, plugins: extenPlugins)
    }
    
    // 返回一组数据
    public func requestList<T: Unboxable>(_ target: Target) -> Promise<[T]> {
        return Promise { fullfill, reject in
            self.request(target, queue: CreamsDispatchQueueGetForQOS(.default)) { result in
                switch result {
                case let .success(response):
                    do {
                        guard let jsonArray = try response.mapJSON() as? [UnboxableDictionary] else {
                            reject(RequestError.jsonMapError)
                            return
                        }
                        
                        let data: [T] = try Unbox.unbox(dictionaries: jsonArray, allowInvalidElements: false)
                        
                        fullfill(data)
                    } catch {
                        reject(RequestError.jsonMapError)
                    }
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
    
    public func request<T: Unboxable>(_ target: Target) -> Promise<[T]> {
        return Promise { fullfill, reject in
            self.request(target, queue: CreamsDispatchQueueGetForQOS(.default)) { result in
                switch result {
                case let .success(response):
                    do {
                        guard let jsonArray = try response.mapJSON() as? [UnboxableDictionary] else {
                            reject(RequestError.jsonMapError)
                            return
                        }
                        
                        let data: [T] = try Unbox.unbox(dictionaries: jsonArray, allowInvalidElements: false)
                        
                        fullfill(data)
                    } catch {
                        reject(RequestError.jsonMapError)
                    }
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
    
    public func request<T: Unboxable>(_ target: Target, cancelableRef: inout Cancellable) -> Promise<[T]> {
        return Promise { fullfill, reject in
            cancelableRef = self.request(target, queue: CreamsDispatchQueueGetForQOS(.default)) { result in
                switch result {
                case let .success(response):
                    do {
                        guard let jsonArray = try response.mapJSON() as? [UnboxableDictionary] else {
                            reject(RequestError.jsonMapError)
                            return
                        }
                        
                        let data: [T] = try Unbox.unbox(dictionaries: jsonArray, allowInvalidElements: false)
                        
                        fullfill(data)
                    } catch {
                        reject(RequestError.jsonMapError)
                    }
                case let .failure(error):
                    reject(error)
                }
            }
            
        }
    }
    
    // 返回单个数据
    public func request<T: Unboxable>(_ target: Target) -> Promise<T> {
        return Promise { fullfill, reject in
            self.request(target, queue: CreamsDispatchQueueGetForQOS(.default)) { result in
                switch result {
                case let .success(response):
                    do {
                        if T.self is BlankResponse.Type {
                            fullfill(BlankResponse() as! T)
                            return
                        }
                        
                        if T.self is StatusCodeResponse.Type {
                            fullfill(StatusCodeResponse(code: response.statusCode) as! T)
                            return
                        }
                        
                        guard let json = try response.mapJSON() as? UnboxableDictionary else {
                            reject(RequestError.jsonMapError)
                            return
                        }
                        
                        let data: T = try Unbox.unbox(dictionary: json)
                        
                        fullfill(data)
                    } catch {
                        reject(RequestError.jsonMapError)
                    }
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
    
    public func request<T: Unboxable>(_ target: Target, cancelableRef: inout Cancellable) -> Promise<T> {
        return Promise { fullfill, reject in
            cancelableRef = self.request(target, queue: CreamsDispatchQueueGetForQOS(.default)) { result in
                switch result {
                case let .success(response):
                    do {
                        if T.self is BlankResponse.Type {
                            fullfill(BlankResponse() as! T)
                            return
                        }
                        
                        if T.self is StatusCodeResponse.Type {
                            fullfill(StatusCodeResponse(code: response.statusCode) as! T)
                            return
                        }
                        
                        guard let json = try response.mapJSON() as? UnboxableDictionary else {
                            reject(RequestError.jsonMapError)
                            return
                        }
                        
                        let data: T = try Unbox.unbox(dictionary: json)
                        
                        fullfill(data)
                    } catch {
                        reject(RequestError.jsonMapError)
                    }
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
    
    
    public func requestPlainData<T>(_ target: Target) -> Promise<T> {
        return Promise { fullfill, reject in
            self.request(target, queue: CreamsDispatchQueueGetForQOS(.default)) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try response.mapJSON()
                        if let plainData = json as? T {
                            fullfill(plainData)
                        } else {
                            reject(RequestError.jsonMapError)
                        }
                        
                    } catch {
                        reject(RequestError.jsonMapError)
                    }
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
}
