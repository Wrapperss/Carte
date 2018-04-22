//
//  Request.swift
//  CreamsAgent
//
//  Created by hasayakey on 14/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Moya
import Unbox
import Result
import RxSwift
import UPYUN

public typealias ResponseWrapper<T> = Observable<Result<T, RequestError>>

public enum RequestCachePolicy {
    case none
    case time(Int)
}

public protocol RequestTargetType: TargetType, AccessTokenAuthorizable {
    var parameters: [String: Any]? { get }
    var cachePolicy: RequestCachePolicy { get }
}

final class Request<Target>: MoyaProvider<Target> where Target: RequestTargetType {

    public init(plugins: [PluginType] = []) {
        let plugin = Plugin()
        var extenPlugins: [PluginType] = [plugin.authorizationPlugin, plugin.errorPlugin]
        #if DEBUG
            extenPlugins.append(plugin.loggerPlugin)
        #endif
        super.init(manager: sessionManager, plugins: extenPlugins, trackInflights: false)
    }
}

extension Request: ReactiveCompatible {

}

public extension Reactive where Base: MoyaProviderType {

    public func request<T: Unboxable>(target: Base.Target, mapType: T.Type) -> Observable<Result<T, RequestError>> {
        return base.rxRequesOneResponse(target: target, mapType: mapType)
    }

    public func request<T: Unboxable>(_ target: Base.Target, mapType: T.Type) -> Observable<Result<[T], RequestError>> {
        return base.rxRequestListResponse(target, mapType: mapType)
    }

    public func request<T: Unboxable>(objectTarget: Base.Target, mapType: T.Type) -> Observable<Result<T, RequestError>> {
        return base.rxRequesOneResponse(target: objectTarget, mapType: mapType)
    }

    public func request<T: Unboxable>(listTarget: Base.Target, mapType: T.Type) -> Observable<Result<[T], RequestError>> {
        return base.rxRequestListResponse(listTarget, mapType: mapType)
    }
    
    public func uploadImages(images: [UIImage]) -> Observable<Result<[UpyunImage], RequestError>> {
        return base.rxUploadImagesResponse(images)
    }
}

fileprivate extension MoyaProviderType {

    
    fileprivate func rxRequesOneResponse<T: Unboxable>(target: Target, mapType: T.Type) -> Observable<Result<T, RequestError>> {

        return Observable.create { [weak self] observer in

//            if let target = target as? RequestTargetType {
//                switch target.cachePolicy {
//                case .none:
//                    break
//                case .time(let time):
//                    break
//                }
//            }

            guard let `self` = self else {
                return Disposables.create()
            }

            let cancellableToken = self.request(target, callbackQueue: DispatchQueue.main, progress: nil) { result in
                switch result {
                case let .success(response):
                    do {
                        if mapType is StatusCodeResponse.Type {
                            observer.onNext(Result.success(StatusCodeResponse(code: response.statusCode) as! T))
                            observer.onCompleted()
                        } else {
                            let data: T = try response.unbox(object: mapType)
                            observer.onNext(Result.success(data))
                            observer.onCompleted()
                        }
                    } catch {
                        #if DEBUG || RELEASE
                            if let error = error as? UnboxError {
                                observer.onNext(Result.failure(RequestError.jsonMapping(error.description)))
                            }else {
                                observer.onNext(Result.failure(RequestError.jsonMapping(error.localizedDescription)))
                            }
                        #else
                            observer.onNext(Result.failure(RequestError.jsonMapping(error.localizedDescription)))
                        #endif
                        observer.onCompleted()
                    }
                case let .failure(error):
                    if case let .underlying( _error, _) = error {
                        observer.onNext(Result.failure(_error as! RequestError))
                        observer.onCompleted()
                    } else {
                        observer.onNext(Result.failure(RequestError.unkonwn))
                        observer.onCompleted()
                    }
                }
            }

            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }

    fileprivate func rxRequestListResponse<T: Unboxable>(_ target: Target, mapType: T.Type) -> Observable<Result<[T], RequestError>> {

        return Observable.create { [weak self] observer in

//            if let target = target as? RequestTargetType {
//                switch target.cachePolicy {
//                case .none:
//                    break
//                case .time(let time):
//                    break
//                }
//            }

            guard let `self` = self else {
                return Disposables.create()
            }

            let cancellableToken = self.request(target, callbackQueue: DispatchQueue.main, progress: nil) { result in
                switch result {
                case let .success(response):

                    do {
                        let data: [T] = try response.unbox(array: T.self)
                        observer.onNext(.success(data))
                        observer.onCompleted()
                    } catch {
                        #if DEBUG || RELEASE
                            if let error = error as? UnboxError {
                                observer.onNext(Result.failure(RequestError.jsonMapping(error.description)))
                            }else {
                                observer.onNext(Result.failure(RequestError.jsonMapping(error.localizedDescription)))
                            }
                        #else
                            observer.onNext(Result.failure(RequestError.jsonMapping(error.localizedDescription)))
                        #endif
                        observer.onCompleted()
                    }
                case let .failure(error):
                    if case let .underlying( _error, _) = error {
                        observer.onNext(Result.failure(_error as! RequestError))
                        observer.onCompleted()
                    } else {
                        observer.onNext(Result.failure(RequestError.unkonwn))
                        observer.onCompleted()
                    }
                }
            }

            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
    
    
    fileprivate func rxUploadImagesResponse(_ images: [UIImage]) -> Observable<Result<[UpyunImage], RequestError>> {
        
        return Observable.create { [weak self] observer in
            guard let _ = self else {
                return Disposables.create()
            }
            UploadAPI.uploadImages(images: images, complete: { (images) in
                observer.onNext(.success(images))
                observer.onCompleted()
            }, fail: { (errorInfo) in
                observer.onNext(Result.failure(RequestError.unkonwn))
                observer.onCompleted()
            })

            return Disposables.create {
            }
        }
    }
    
}

private let sessionManager: Manager = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders

    let manager = Manager(configuration: configuration)
    manager.startRequestsImmediately = false
    return manager
}()

private struct Plugin: RequestLoggerPluginStaticFetchable,
RequestErrorPluginStaticFetchable,
RequestAuthorizationPluginStaticFetchable {

}
