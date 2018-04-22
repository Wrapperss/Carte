//
//  RegexHelper.swift
//  CreamsAgent
//
//  Created by hasayakey on 19/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import UIKit
import Foundation

public protocol Ruleable {
    func validate(_ value: String) -> Bool
    func errorMessage() -> String
}

open class CreamsRegexRule: Ruleable {
    
    fileprivate var regex: String = "^(?=.*?[A-Z])(?=.*?[a-z]).{8,20}$"
    fileprivate var message: String
    
    public init(regex: String, errorMessage: String = "密码不符合要求") {
        self.regex = regex
        self.message = errorMessage
    }
    
    open func validate(_ value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", self.regex)
        return test.evaluate(with: value)
    }
    
    open func errorMessage() -> String {
        return message
    }
    
}

final class NumberRule: CreamsRegexRule {
    
    static let regex = "[0-9]*$"
    
    public convenience init(message: String = "请输入正确的数字") {
        self.init(regex: NumberRule.regex, errorMessage : message)
    }
    
}

/// 识别小数
public class DecimalRule: CreamsRegexRule {
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - digit: 小数点后最多几位
    ///   - message: 错误信息
    public convenience init(digit: UInt = 2, message: String = "请输入正确的数字") {
        self.init(regex: "^([0-9]+)?(\\.([0-9]{1,2})?)?$", errorMessage : message)
    }
}

extension UInt {
    
    var iterationString: String {
        
        if self == 0 || self == 1 {
            return "1"
        }
        
        var reduce: UInt = 1
        var result: String = "1"
        
        while reduce < self {
            reduce += 1
            result.append(",\(reduce)")
        }
        
        return result
    }
}

final class PasswordRule: CreamsRegexRule {
    
    // Other Regexes that you can se
    
    // 8 characters. One uppercase. One Lowercase. One number.
    // static let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    //
    // no length. One uppercase. One lowercae. One number.
    // static let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).*?$"
    
    // 8 characeters. One uppercase.
    //^(?=.*?[A-Z]).{8,}$
    
    static let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,20}$"
    
    public convenience init(message: String = "密码不符合要求") {
        self.init(regex: PasswordRule.regex, errorMessage : message)
    }
    
}

final class PhoneNumberRule: CreamsRegexRule {
    
    static let mobileRegex = "^1[3|4|5|7|8]\\d{9}$"
    
    static let chinaMobileRegex = "^(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
    static let chinaUnicomRegex = "^(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
    static let chinaTelecomRegex = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"
    
    public convenience init(message: String = "手机号码格式不正确") {
        self.init(regex: PhoneNumberRule.mobileRegex, errorMessage : message)
    }
    
    override func validate(_ value: String) -> Bool {
        
        if value.count != 11 {
            return false
        }
        
        return evaluate(PhoneNumberRule.mobileRegex, value) ||
            evaluate(PhoneNumberRule.chinaMobileRegex, value) ||
            evaluate(PhoneNumberRule.chinaUnicomRegex, value) ||
            evaluate(PhoneNumberRule.chinaTelecomRegex, value)
    }
    
    private func evaluate(_ regex: String, _ value: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: value)
    }
    
}

final class EmailRule: CreamsRegexRule {
    
    static let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    public convenience init(message: String = "请输入正确的邮箱") {
        self.init(regex: EmailRule.regex, errorMessage : message)
    }
    
}
