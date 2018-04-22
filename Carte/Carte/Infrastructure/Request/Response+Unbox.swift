//
//  Response+Unbox.swift
//  CreamsAgent
//
//  Created by hasayakey on 20/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Moya
import Unbox

public extension Response {

    public func unbox<T: Unboxable>(object: T.Type) throws -> T {
        guard let json = try mapJSON() as? UnboxableDictionary else {
            throw RequestError.jsonMapping("接受数据发生格式化错误")
        }
        return try Unbox.unbox(dictionary: json)
    }

    public func unbox<T: Unboxable>(object: T.Type, atKey: String) throws -> T {
        guard let json = try mapJSON() as? UnboxableDictionary else {
            throw RequestError.jsonMapping("接受数据发生格式化错误")
        }
        return try Unbox.unbox(dictionary: json, atKey: atKey)
    }

    public func unbox<T: Unboxable>(object: T.Type, atKeyPath: String) throws -> T {
        guard let json = try mapJSON() as? UnboxableDictionary else {
            throw RequestError.jsonMapping("接受数据发生格式化错误")
        }
        return try Unbox.unbox(dictionary: json, atKeyPath: atKeyPath)
    }

    public func unbox<T: Unboxable>(array: T.Type) throws -> [T] {
        guard let jsonArray = try mapJSON() as? [UnboxableDictionary] else {
            throw RequestError.jsonMapping("接受数据发生格式化错误")
        }
        return try Unbox.unbox(dictionaries: jsonArray)
    }

    public func unbox<T: Unboxable>(array: T.Type, atKey: String) throws -> [T] {
        guard let json = try mapJSON() as? UnboxableDictionary else {
            throw RequestError.jsonMapping("接受数据发生格式化错误")
        }
        return try Unbox.unbox(dictionary: json, atKey: atKey)
    }

    public func unbox<T: Unboxable>(array: T.Type, atKeyPath: String) throws -> [T] {
        guard let json = try mapJSON() as? UnboxableDictionary else {
            throw RequestError.jsonMapping("接受数据发生格式化错误")
        }
        return try Unbox.unbox(dictionary: json, atKeyPath: atKeyPath)
    }

}
