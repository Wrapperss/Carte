//
//  Number+Date.swift
//  creams
//
//  Created by hasayakey on 9/11/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Foundation

extension UInt64 {

    /// 2017/08/04 这种形式的日期
    ///
    /// - Returns: 日期
    func toDateString() -> String {
        return toDateString(Date.formatterWithSlash)
    }

    /// 默认的格式是 2017-08-04 这种
    ///
    /// - Parameter formatter: 日期格式化
    /// - Returns: 日期
    func toDateString(_ formatter: DateFormatter) -> String {
        let timeInterval = TimeInterval(self / 1_000)
        let date = Date(timeIntervalSince1970: timeInterval)
        return formatter.string(from: date)
    }
}

extension Optional where Wrapped == UInt64 {

    /// 2017/08/04 这种形式的日期
    ///
    /// - Returns: 日期
    func toDateString() -> String {

        guard let value = self else {
            return emptyContent
        }

        return value.toDateString()
    }

    /// 默认的格式是 2017-08-04 这种
    ///
    /// - Parameter formatter: 日期格式化
    /// - Returns: 日期
    func toDateString(_ formatter: DateFormatter) -> String {

        guard let value = self else {
            return ""
        }

        return value.toDateString(formatter)
    }
}
