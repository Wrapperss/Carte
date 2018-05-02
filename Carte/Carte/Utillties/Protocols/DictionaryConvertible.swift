//
//  DictionaryConvertible.swift
//  CreamsAgent
//
//  Created by Rawlings on 21/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation


private protocol RequestParameterRepresentable { var requestString: String { get } }
private extension RequestParameterRepresentable { var requestString: String { return String(describing: self) } }

extension Int: RequestParameterRepresentable {
    var requestString: String { return "\(self)" }
}
extension UInt: RequestParameterRepresentable {
    var requestString: String { return "\(self)" }
}
extension Float: RequestParameterRepresentable {
    var requestString: String { return "\(self)" }
}
extension Double: RequestParameterRepresentable {
    var requestString: String { return "\(cleanString)" }
}
extension String: RequestParameterRepresentable {
    var requestString: String { return self }
}



protocol DictionaryConvertible {}

extension DictionaryConvertible {
    
    /// Dictionary From Children
    
    var dictionary: [String: Any] {
        var dict = [String: Any]()
        for child in Mirror(reflecting: self).children {
            if let key = child.label {
                dict[key] = child.value
                if let dictable = dict[key] as? DictionaryConvertible {
                    dict[key] = dictable.dictionary
                }
                if let arr = dict[key] as? [DictionaryConvertible] {
                    dict[key] = arr.map { $0.dictionary }
                }
            }
        }
        
        return dict
    }
    
    /// Dictionary From Children Without Nil Value
    
    var flatDictionary: [String: Any] {
        var dict = [String: Any]()
        for child in Mirror(reflecting: self).children {
            if let key = child.label {
                let subMirror = Mirror(reflecting: child.value)
                if subMirror.displayStyle == .optional {
                    if !subMirror.children.isEmpty {
                        dict[key] = subMirror.children.first!.value
                    }
                } else {
                    dict[key] = child.value
                }
                if let dictable = dict[key] as? DictionaryConvertible {
                    dict[key] = dictable.flatDictionary
                }
                if let arr = dict[key] as? [DictionaryConvertible] {
                    dict[key] = arr.map { $0.flatDictionary }
                }
            }
        }
        
        return dict
    }
    
    
    
    /// Server Client Required Dictionary Format
    ///
    /// - Parameter arrayConversion: [1, 2, 3] --> "1,2,3"
    
    func toDictionary(_ arrayConversion: Bool = true) -> [String: Any] {
        if !arrayConversion { return flatDictionary }
        
        var dict = [String: Any]()
        for child in Mirror(reflecting: self).children {
            if let key = child.label {
                let value: Any = child.value
                let subMirror = Mirror(reflecting: value)
                if subMirror.displayStyle == .optional {
                    if !subMirror.children.isEmpty {
                        dict[key] = subMirror.children.first!.value
                    }
                } else {
                    dict[key] = child.value
                }
                if let arr = dict[key] as? [RequestParameterRepresentable], arrayConversion {
                    dict[key] = arr.map { $0.requestString }.joined(separator: ",")
                }
                if let dictable = dict[key] as? DictionaryConvertible {
                    dict[key] = dictable.toDictionary(arrayConversion)
                }
                if let arr = dict[key] as? [DictionaryConvertible] {
                    dict[key] = arr.map { $0.toDictionary(arrayConversion) }
                }
            }
        }
        
        return dict
    }
}



/// judge if value which is 'Any' type has real value or not
///
/// - Returns: true -> has real value / false -> nil
func judgeRealValue(value: Any) -> Bool {
    let subMirror = Mirror(reflecting: value)
    if subMirror.displayStyle == .optional {
        if subMirror.children.isEmpty {
            return false
        } else {
            return true
        }
    } else {
        return true
    }
}

