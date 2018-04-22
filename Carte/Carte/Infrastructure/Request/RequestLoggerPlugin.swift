//
//  RequestLoggerPlugin.swift
//  CreamsAgent
//
//  Created by hasayakey on 20/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Result
import Moya
import Foundation

public protocol RequestLoggerPluginStaticFetchable {
    var loggerPlugin: RequestLoggerPlugin { get }
}

extension RequestLoggerPluginStaticFetchable {
    public var loggerPlugin: RequestLoggerPlugin {
        return RequestLoggerPlugin.default
    }
}

public final class _NetworkLoggerPlugin: PluginType {
    fileprivate let loggerId = "Moya_Logger"
    fileprivate let dateFormatString = "dd/MM/yyyy HH:mm:ss"
    fileprivate let dateFormatter = DateFormatter()
    fileprivate let separator = ", "
    fileprivate let terminator = "\n"
    fileprivate let cURLTerminator = "\\\n"
    fileprivate let output: (_ separator: String, _ terminator: String, _ items: Any...) -> Void
    fileprivate let requestDataFormatter: ((Data) -> (String))?
    fileprivate let responseDataFormatter: ((Data) -> (Data))?

    /// If true, also logs response body data.
    public let isVerbose: Bool
    public let cURL: Bool

    static let `default`: _NetworkLoggerPlugin = {
        return _NetworkLoggerPlugin(verbose: true)
    }()

    public init(verbose: Bool = false, cURL: Bool = false, output: ((_ separator: String, _ terminator: String, _ items: Any...) -> Void)? = nil, requestDataFormatter: ((Data) -> (String))? = nil, responseDataFormatter: ((Data) -> (Data))? = nil) {
        self.cURL = cURL
        self.isVerbose = verbose
        self.output = output ?? _NetworkLoggerPlugin.reversedPrint
        self.requestDataFormatter = requestDataFormatter
        self.responseDataFormatter = responseDataFormatter
    }

    public func willSend(_ request: RequestType, target: TargetType) {
        if let request = request as? CustomDebugStringConvertible, cURL {
            output(separator, terminator, request.debugDescription)
            return
        }
        outputItems(logNetworkRequest(request.request as URLRequest?))
    }

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case .success(let response) = result {
            outputItems(logNetworkResponse(response.response, data: response.data, target: target))
        } else {
            outputItems(logNetworkResponse(nil, data: nil, target: target))
        }
    }

    fileprivate func outputItems(_ items: [String]) {
        if isVerbose {
            items.forEach { output(separator, terminator, $0) }
        } else {
            output(separator, terminator, items)
        }
    }
}

private extension _NetworkLoggerPlugin {

    var date: String {
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }

    func format(_ loggerId: String, date: String, identifier: String, message: String) -> String {
        return "\(loggerId): [\(date)] \(identifier): \(message)"
    }

    func logNetworkRequest(_ request: URLRequest?) -> [String] {

        var output = [String]()

        output += [format(loggerId, date: date, identifier: "Request", message: request?.description ?? "(invalid request)")]

        if let headers = request?.allHTTPHeaderFields {
            output += [format(loggerId, date: date, identifier: "Request Headers", message: headers.description)]
        }

        if let bodyStream = request?.httpBodyStream {
            output += [format(loggerId, date: date, identifier: "Request Body Stream", message: bodyStream.description)]
        }

        if let httpMethod = request?.httpMethod {
            output += [format(loggerId, date: date, identifier: "HTTP Request Method", message: httpMethod)]
        }

        if let body = request?.httpBody, let stringOutput = requestDataFormatter?(body) ?? String(data: body, encoding: .utf8), isVerbose {
            output += [format(loggerId, date: date, identifier: "Request Body", message: stringOutput)]
        }

        return output
    }

    func logNetworkResponse(_ response: HTTPURLResponse?, data: Data?, target: TargetType) -> [String] {
        guard let response = response else {
            return [format(loggerId, date: date, identifier: "Response", message: "Received empty network response for \(target).")]
        }

        var output = [String]()

        output += [format(loggerId, date: date, identifier: "Response", message: response.description)]

        if let data = data, let stringData = String(data: responseDataFormatter?(data) ?? data, encoding: String.Encoding.utf8), isVerbose {
            output += [stringData]
        }

        return output
    }
}

fileprivate extension _NetworkLoggerPlugin {
    static func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            print(item, separator: separator, terminator: terminator)
        }
    }
}

public final class RequestLoggerPlugin: PluginType {

    fileprivate let loggerId = "RequestLogger"
    fileprivate let dateFormatString = "yyyy/MM/dd/ HH:mm:ss"
    fileprivate let dateFormatter = DateFormatter()
    fileprivate let separator = ", "
    fileprivate let terminator = "\n"
    fileprivate let cURLTerminator = "\\\n"
    fileprivate let output: (_ separator: String, _ terminator: String, _ items: Any...) -> Void
    fileprivate let responseDataFormatter: ((Data) -> (Data))?

    /// If true, also logs response body data.
    public let isVerbose: Bool
    public let cURL: Bool

    fileprivate static let `default`: RequestLoggerPlugin = {
        return RequestLoggerPlugin(verbose: true)
    }()

    public init(verbose: Bool = false, cURL: Bool = false, output: @escaping (_ separator: String, _ terminator: String, _ items: Any...) -> Void = RequestLoggerPlugin.reversedPrint, responseDataFormatter: ((Data) -> (Data))? = nil) {
        self.cURL = cURL
        self.isVerbose = verbose
        self.output = output
        self.responseDataFormatter = responseDataFormatter
    }

    public func willSend(_ request: RequestType, target: TargetType) {
        if let request = request as? CustomDebugStringConvertible, cURL {
            output(separator, terminator, request.debugDescription)
            return
        }
        outputItems(logNetworkRequest(request.request as URLRequest?))
    }

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case .success(let response) = result {
            outputItems(logNetworkResponse(response, data: response.data, target: target))
        } else {
            outputItems(logNetworkResponse(nil, data: nil, target: target))
        }
    }

    fileprivate func outputItems(_ items: [String]) {
        if isVerbose {
            items.forEach { output(separator, terminator, $0) }
        } else {
            output(separator, terminator, items)
        }
    }
}

private extension RequestLoggerPlugin {

    var date: String {
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }

    func format(_ loggerId: String, date: String, identifier: String, message: String) -> String {
        return "\(loggerId): [\(date)] \(identifier): \(message)"
    }

    func logNetworkRequest(_ request: URLRequest?) -> [String] {

        var flag = String(repeatElement("*", count: 20))
        flag = "\n\(flag) [ Request ] \(flag)\n"
        var output = [flag]

        output += [format(loggerId, date: date, identifier: "Request", message: request?.description ?? "(invalid request)")]

        if let bodyStream = request?.httpBodyStream {
            output += [format(loggerId, date: date, identifier: "Request Body Stream", message: bodyStream.description)]
        }

        if let httpMethod = request?.httpMethod {
            output += [format(loggerId, date: date, identifier: "HTTP Request Method", message: httpMethod)]
        }

        if let body = request?.httpBody, let stringOutput = String(data: body, encoding: .utf8), isVerbose {
            output += [format(loggerId, date: date, identifier: "Request Body", message: stringOutput)]
        }

        return output
    }

    func logNetworkResponse(_ response: Response?, data: Data?, target: TargetType) -> [String] {

        guard let response = response else {
            return [format(loggerId, date: date, identifier: "Response", message: "Received empty network response for \(target).")]
        }

        var flag = String(repeatElement("*", count: 20))
        flag = "\n\(flag) [ Response ] \(flag)\n"
        var output = [flag]

        output += [format(loggerId, date: date, identifier: "Response", message: response.creamsDescription)]

        if let data = data, let json = JSONSerialization.unbox(data: data), isVerbose {
            output += [json.string.conslePrintString]
        }

        return output
    }

}

fileprivate extension Dictionary {

    var string: String {
        return (self.flatMap({ (key, value) -> String in
            return "\(key) : \(value)"
        }) as Array)
            .joined(separator: "\\n")
            + "\\n\\n"
            + String(repeatElement("*", count: 40))
            + "\\n\\n"
    }
}

fileprivate extension String {

    var conslePrintString: String {

        guard let data = "\""
            .appending(
                replacingOccurrences(of: "\\u", with: "\\U")
                    .replacingOccurrences(of: "\"", with: "\\\"")
            )
            .appending("\"")
            .data(using: .utf8) else {

            return self
        }

        guard let propertyList = try? PropertyListSerialization.propertyList(from: data,
                                                                             options: [],
                                                                             format: nil) else {
            return self
        }

        guard let string = propertyList as? String else {
            return self
        }

        return string.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
}

fileprivate extension JSONSerialization {
    static func unbox(data: Data, options: ReadingOptions = []) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: options) as? [String: Any]
        } catch {
            return nil
        }
    }
}

fileprivate extension RequestLoggerPlugin {
    static func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            print(item, separator: separator, terminator: terminator)
        }
    }
}

fileprivate extension Response {

    var creamsDescription: String {

        guard let request = request else {
            return "Status Code: \(statusCode)\n"
        }

        guard let url = request.url else {
            return "Status Code: \(statusCode)\n"
        }

        return "\(url), Status Code: \(statusCode)\n"
    }
}
