//
//  DateExtension.swift
//  creams
//
//  Created by Jahov on 23/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import Foundation

extension Date {

    static let fullFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()

    static let formatterOnlyTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()

    static let monthFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()

    static let formatterMonth: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM月dd日"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()

    static let formatterWithPoint: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()

    static let formatterWithSlash: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()

    func fullString() -> String {
        return Date.fullFormatter.string(from: self)
    }

    func onlyDateString() -> String {
        return Date.formatterWithSlash.string(from: self)
    }

    func onlyTimeString() -> String {
        return Date.formatterOnlyTime.string(from: self)
    }

    func dateString() -> String {
        return Date.monthFormatter.string(from: self)
    }

    func dateString(_ formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }

    func stringWithFormat(_ formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }

    static func initFromCreamsTimestamp(_ milliTimestamp: UInt64?) -> Date? {
        guard let timestamp = milliTimestamp else {
            return nil
        }
        return Date(timeIntervalSince1970: TimeInterval(timestamp / 1_000))
    }

    static func initFromCreamsTimestamp(_ milliTimestamp: UInt64) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(milliTimestamp / 1_000))
    }

    static func initFromCreamsTimestampPlus8Hours(_ milliTimestamp: UInt64?) -> Date? {
        guard let timestamp = milliTimestamp else {
            return nil
        }
        return Date(timeIntervalSince1970: TimeInterval(timestamp / 1_000 + 8 * 3600))
    }
}

extension Date {

    static var todayTimestamp: UInt64 {
        return UInt64(Date().timeIntervalSince1970 * 1_000)
    }
}

extension Date {

    static var todayString: String {
        return Date().dateString()
    }

    static var yesterdayString: String {
        return Date().addingTimeInterval(-(24 * 60 * 60)).dateString()
    }

    static var thisWeekBeginDayString: String {
        return Date().weekBeginDay.dateString()
    }

    static var thisWeekEndDayString: String {
        return Date().weekEndDay.dateString()
    }

    static var thisMonthBeginDayString: String {
        return Date().monthBeginDay.dateString()
    }

    static var thisMonthEndDayString: String {
        return Date().monthEndDay.dateString()
    }
}

extension Date {

    private static let iso8601Calendar = Calendar(identifier: .iso8601)

    var weekBeginDay: Date {
        let calendar = Date.iso8601Calendar
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        let date = calendar.date(from: components)!
        return date
    }

    var weekEndDay: Date {
        return Calendar.current.date(byAdding: .second, value: 604_799, to: weekBeginDay)!
    }

    var monthBeginDay: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: self))
        let date = calendar.date(from: components)!
        return date
    }

    var monthEndDay: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: monthBeginDay)!
    }

    static var oneDaymSecond: Int {
        return 86_400_000
    }

}

public extension Date {

    public func plus(seconds s: UInt) -> Date {
        return addComponentsToDate(seconds: Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    public func minus(seconds s: UInt) -> Date {
        return addComponentsToDate(seconds: -Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    public func plus(minutes m: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    public func minus(minutes m: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: -Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    public func plus(hours h: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }

    public func minus(hours h: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: -Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }

    public func plus(days d: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
    }

    public func minus(days d: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: -Int(d), weeks: 0, months: 0, years: 0)
    }

    public func plus(weeks w: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: Int(w), months: 0, years: 0)
    }

    public func minus(weeks w: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -Int(w), months: 0, years: 0)
    }

    public func plus(months m: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: Int(m), years: 0)
    }

    public func minus(months m: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -Int(m), years: 0)
    }

    public func plus(years y: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: Int(y))
    }

    public func minus(years y: UInt) -> Date {
        return addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
    }

    fileprivate func addComponentsToDate(seconds sec: Int,
                                         minutes min: Int,
                                         hours hrs: Int,
                                         days d: Int,
                                         weeks wks: Int,
                                         months mts: Int,
                                         years yrs: Int) -> Date {
        var components = DateComponents()
        components.second = sec
        components.minute = min
        components.hour = hrs
        components.day = d
        components.weekOfYear = wks
        components.month = mts
        components.year = yrs
        components.timeZone = TimeZone.current
        return Calendar.current.date(byAdding: components, to: self)!
    }

    public func midnightUTCDate() -> Date {
        var components: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        components.nanosecond = 0
        components.timeZone = TimeZone.current
        return Calendar.current.date(from: components)!
    }

    public static func secondsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        var components = Calendar.current.dateComponents([.second], from: d1, to: d2)
        components.timeZone = TimeZone.current
        return components.second!
    }

    public static func minutesBetween(date1 d1: Date, date2 d2: Date) -> Int {
        var components = Calendar.current.dateComponents([.minute], from: d1, to: d2)
        components.timeZone = TimeZone.current
        return components.minute!
    }

    public static func hoursBetween(date1 d1: Date, date2 d2: Date) -> Int {
        var components = Calendar.current.dateComponents([.hour], from: d1, to: d2)
        components.timeZone = TimeZone.current
        return components.hour!
    }

    public static func daysBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: d1) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: d2) else {
            return 0
        }
        return end - start
    }

    public static func weeksBetween(date1 d1: Date, date2 d2: Date) -> Int {
        var components = Calendar.current.dateComponents([.weekOfYear], from: d1, to: d2)
        components.timeZone = TimeZone.current
        return components.weekOfYear!
    }

    public static func monthsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        var components = Calendar.current.dateComponents([.month], from: d1, to: d2)
        components.timeZone = TimeZone.current
        return components.month!
    }

    public static func yearsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        var components = Calendar.current.dateComponents([.year], from: d1, to: d2)
        components.timeZone = TimeZone.current
        return components.year!
    }

    //MARK- Comparison Methods

    public func isGreaterThan(_ date: Date) -> Bool {
        return (compare(date) == .orderedDescending)
    }

    public func isLessThan(_ date: Date) -> Bool {
        return (compare(date) == .orderedAscending)
    }

    //MARK- Computed Properties

    public var day: UInt {
        return UInt(Calendar.current.component(.day, from: self))
    }

    public var month: UInt {
        return UInt(NSCalendar.current.component(.month, from: self))
    }

    public var year: UInt {
        return UInt(NSCalendar.current.component(.year, from: self))
    }

    public var hour: UInt {
        return UInt(NSCalendar.current.component(.hour, from: self))
    }

    public var minute: UInt {
        return UInt(NSCalendar.current.component(.minute, from: self))
    }

    public var second: UInt {
        return UInt(NSCalendar.current.component(.second, from: self))
    }

    public var isToday: Bool {
        let today = Date()
        return today.day == day && today.month == month && today.year == year
    }

    public var isYesterday: Bool {
        let yesterday = Date().addingTimeInterval(-(24 * 60 * 60))
        return yesterday.day == day && yesterday.month == month && yesterday.year == year
    }

    public var isThisWeek: Bool {
        let begin = Date().weekBeginDay
        let end = Date().weekEndDay
        return begin <= self && self <= end
    }

    public var isThisMonth: Bool {
        let begin = Date().monthBeginDay
        let end = Date().monthEndDay
        return begin <= self && self <= end
    }
}
