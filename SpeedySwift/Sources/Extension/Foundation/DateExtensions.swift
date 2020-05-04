//
//  Datepublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/5/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Enums
public extension Date {

    /// 日的名字格式
    ///
    /// - threeLetters: 3 letter day abbreviation of day name.
    /// - oneLetter: 1 letter day abbreviation of day name.
    /// - full: Full day name.
    enum DayNameStyle {
        /// 3 letter day abbreviation of day name.
        case threeLetters

        /// 1 letter day abbreviation of day name.
        case oneLetter

        /// Full day name.
        case full
    }

    /// 月的名字缩写
    ///
    /// - threeLetters: 3 letter month abbreviation of month name.
    /// - oneLetter: 1 letter month abbreviation of month name.
    /// - full: Full month name.
    enum MonthNameStyle {
        /// 3 letter month abbreviation of month name.
        case threeLetters

        /// 1 letter month abbreviation of month name.
        case oneLetter

        /// Full month name.
        case full
    }

}

// MARK: - Properties
public extension Date {

    /// 当前的日历
    var  calendar: Calendar {
        return Calendar.current
    }

    /// 时代
    ///
    ///		Date().era -> 1
    ///
    var  era: Int {
        return Calendar.current.component(.era, from: self)
    }

    /// 季度
    ///
    ///		Date().quarter -> 3 // date in third quarter of the year.
    ///
    var  quarter: Int {
        let month = Double(Calendar.current.component(.month, from: self))
        let numberOfMonths = Double(Calendar.current.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(ceil(month/numberOfMonthsInQuarter))
    }

    /// 一年的第几周
    ///
    ///		Date().weekOfYear -> 2 // second week in the year.
    ///
    var  weekOfYear: Int {
        return Calendar.current.component(.weekOfYear, from: self)
    }

    /// 月的第几周
    ///
    ///		Date().weekOfMonth -> 3 // date is in third week of the month.
    ///
    var  weekOfMonth: Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }

    ///年
    ///
    ///		Date().year -> 2017
    ///
    ///		var someDate = Date()
    ///		someDate.year = 2000 // sets someDate's year to 2000
    ///
    var  year: Int {
        get {
            return Calendar.current.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = Calendar.current.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }

    ///月
    ///
    /// 	Date().month -> 1
    ///
    /// 	var someDate = Date()
    /// 	someDate.month = 10 // sets someDate's month to 10.
    ///
    var  month: Int {
        get {
            return Calendar.current.component(.month, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMonth = Calendar.current.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }

    /// 日
    ///
    /// 	Date().day -> 12
    ///
    /// 	var someDate = Date()
    /// 	someDate.day = 1 // sets someDate's day of month to 1.
    ///
    var  day: Int {
        get {
            return Calendar.current.component(.day, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = Calendar.current.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = Calendar.current.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }

    /// 星期几
    ///
    /// 	Date().weekday -> 5 // fifth day in the current week.
    ///
    var  weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }

    /// 设置小时
    ///
    /// 	Date().hour -> 17 // 5 pm
    ///
    /// 	var someDate = Date()
    /// 	someDate.hour = 13 // sets someDate's hour to 1 pm.
    ///
    var  hour: Int {
        get {
            return Calendar.current.component(.hour, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentHour = Calendar.current.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }

    /// 设置分钟
    ///
    /// 	Date().minute -> 39
    ///
    /// 	var someDate = Date()
    /// 	someDate.minute = 10 // sets someDate's minutes to 10.
    ///
    var  minute: Int {
        get {
            return Calendar.current.component(.minute, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMinutes = Calendar.current.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = Calendar.current.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }

    /// 设置秒数
    ///
    /// 	Date().second -> 55
    ///
    /// 	var someDate = Date()
    /// 	someDate.second = 15 // sets someDate's seconds to 15.
    ///
    var  second: Int {
        get {
            return Calendar.current.component(.second, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentSeconds = Calendar.current.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = Calendar.current.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }

    /// 设置纳秒
    ///
    /// 	Date().nanosecond -> 981379985
    ///
    /// 	var someDate = Date()
    /// 	someDate.nanosecond = 981379985 // sets someDate's seconds to 981379985.
    ///
    var  nanosecond: Int {
        get {
            return Calendar.current.component(.nanosecond, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentNanoseconds = Calendar.current.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds

            if let date = Calendar.current.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }

    /// 设置毫秒
    ///
    /// 	Date().millisecond -> 68
    ///
    /// 	var someDate = Date()
    /// 	someDate.millisecond = 68 // sets someDate's nanosecond to 68000000.
    ///
    var  millisecond: Int {
        get {
            return Calendar.current.component(.nanosecond, from: self) / 1000000
        }
        set {
            let nanoSeconds = newValue * 1000000
            let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(nanoSeconds) else { return }

            if let date = Calendar.current.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }

    /// 是否是未来时间
    ///
    /// 	Date(timeInterval: 100, since: Date()).isInFuture -> true
    ///
    var  isInFuture: Bool {
        return self > Date()
    }

    /// 是否是过去时间
    ///
    /// 	Date(timeInterval: -100, since: Date()).isInPast -> true
    ///
    var  isInPast: Bool {
        return self < Date()
    }

    /// 是否是今日
    ///
    /// 	Date().isInToday -> true
    ///
    var  isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    /// 是否是昨天
    ///
    /// 	Date().isInYesterday -> false
    ///
    var  isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    /// 是否在明天之内
    ///
    /// 	Date().isInTomorrow -> false
    ///
    var  isInTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }

    /// 是否在周末期间.
    var  isInWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }

    /// 是否在工作日内。
    var  isWorkday: Bool {
        return !Calendar.current.isDateInWeekend(self)
    }

    /// 是否在本周内。
    var  isInCurrentWeek: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    /// 是否在当月。
    var  isInCurrentMonth: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    /// 检查日期是否在当年之内。
    var  isInCurrentYear: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }

    /// ISO8601 时间  国际标准化组织的国际标准ISO 8601是日期和时间的表示方法
    ///
    /// 	Date().iso8601String -> "2017-01-12T14:51:29.574Z"
    ///
    var  iso8601String: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        return dateFormatter.string(from: self).appending("Z")
    }

    /// 最接近5分钟。
    ///
    /// 	var date = Date() // "5:54 PM"
    /// 	date.minute = 32 // "5:32 PM"
    /// 	date.nearestFiveMinutes // "5:30 PM"
    ///
    /// 	date.minute = 44 // "5:44 PM"
    /// 	date.nearestFiveMinutes // "5:45 PM"
    ///
    var  nearestFiveMinutes: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
        let min = components.minute!
        components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
        components.second = 0
        components.nanosecond = 0
        return Calendar.current.date(from: components)!
    }

    /// 最接近10分钟。
    ///
    /// 	var date = Date() // "5:57 PM"
    /// 	date.minute = 34 // "5:34 PM"
    /// 	date.nearestTenMinutes // "5:30 PM"
    ///
    /// 	date.minute = 48 // "5:48 PM"
    /// 	date.nearestTenMinutes // "5:50 PM"
    ///
    var  nearestTenMinutes: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
        let min = components.minute!
        components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
        components.second = 0
        components.nanosecond = 0
        return Calendar.current.date(from: components)!
    }

    /// 最近的一刻钟。
    ///
    /// 	var date = Date() // "5:57 PM"
    /// 	date.minute = 34 // "5:34 PM"
    /// 	date.nearestQuarterHour // "5:30 PM"
    ///
    /// 	date.minute = 40 // "5:40 PM"
    /// 	date.nearestQuarterHour // "5:45 PM"
    ///
    var  nearestQuarterHour: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
        let min = components.minute!
        components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
        components.second = 0
        components.nanosecond = 0
        return Calendar.current.date(from: components)!
    }

    /// 最接近半小时
    ///
    /// 	var date = Date() // "6:07 PM"
    /// 	date.minute = 41 // "6:41 PM"
    /// 	date.nearestHalfHour // "6:30 PM"
    ///
    /// 	date.minute = 51 // "6:51 PM"
    /// 	date.nearestHalfHour // "7:00 PM"
    ///
    var  nearestHalfHour: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
        let min = components.minute!
        components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        components.nanosecond = 0
        return Calendar.current.date(from: components)!
    }

    /// 最近的小时。
    ///
    /// 	var date = Date() // "6:17 PM"
    /// 	date.nearestHour // "6:00 PM"
    ///
    /// 	date.minute = 36 // "6:36 PM"
    /// 	date.nearestHour // "7:00 PM"
    ///
    var  nearestHour: Date {
        let min = Calendar.current.component(.minute, from: self)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour]
        let date = Calendar.current.date(from: Calendar.current.dateComponents(components, from: self))!

        if min < 30 {
            return date
        }
        return Calendar.current.date(byAdding: .hour, value: 1, to: date)!
    }

    /// 系统当前使用的时区。
    ///
    ///		Date().timeZone -> Europe/Istanbul (current)
    ///
    var  timeZone: TimeZone {
        return Calendar.current.timeZone
    }

    /// 昨天的日期。
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let yesterday = date.yesterday // "Oct 2, 2018, 10:57:11"
    ///
    var  yesterday: Date {
        return addingTimeInterval(-86400.0)
    }

    /// UNIX时间戳的日期。
    ///
    ///		Date().unixTimestamp -> 1484233862.826291
    ///
    var  unixTimestamp: Double {
        return timeIntervalSince1970
    }

}

// MARK: - Methods
public extension Date {

    /// 时间操作
    ///
    /// 	let date = Date() // "Jan 12, 2017, 7:07 PM"
    /// 	let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    /// 	let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    /// 	let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    /// 	let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of components to add.
    /// - Returns: original date + multiples of component added.
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }

    /// 时间操作
    ///
    /// 	var date = Date() // "Jan 12, 2017, 7:07 PM"
    /// 	date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    /// 	date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    /// 	date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    /// 	date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of compnenet to add.
    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = Calendar.current.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }

    // swiftlint:disable function_body_length, function_body_length
    // swiftlint:disable cyclomatic_complexity
    /// 改变时间
    ///
    /// 	let date = Date() // "Jan 12, 2017, 7:07 PM"
    /// 	let date2 = date.changing(.minute, value: 10) // "Jan 12, 2017, 7:10 PM"
    /// 	let date3 = date.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
    /// 	let date4 = date.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
    /// 	let date5 = date.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: new value of compnenet to change.
    /// - Returns: original date after changing given component to given value.
    func changing(_ component: Calendar.Component, value: Int) -> Date? {
        switch component {
        case .nanosecond:
            let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentNanoseconds = Calendar.current.component(.nanosecond, from: self)
            let nanosecondsToAdd = value - currentNanoseconds
            return Calendar.current.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self)

        case .second:
            let allowedRange = Calendar.current.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentSeconds = Calendar.current.component(.second, from: self)
            let secondsToAdd = value - currentSeconds
            return Calendar.current.date(byAdding: .second, value: secondsToAdd, to: self)

        case .minute:
            let allowedRange = Calendar.current.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentMinutes = Calendar.current.component(.minute, from: self)
            let minutesToAdd = value - currentMinutes
            return Calendar.current.date(byAdding: .minute, value: minutesToAdd, to: self)

        case .hour:
            let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentHour = Calendar.current.component(.hour, from: self)
            let hoursToAdd = value - currentHour
            return Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self)

        case .day:
            let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentDay = Calendar.current.component(.day, from: self)
            let daysToAdd = value - currentDay
            return Calendar.current.date(byAdding: .day, value: daysToAdd, to: self)

        case .month:
            let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentMonth = Calendar.current.component(.month, from: self)
            let monthsToAdd = value - currentMonth
            return Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self)

        case .year:
            guard value > 0 else { return nil }
            let currentYear = Calendar.current.component(.year, from: self)
            let yearsToAdd = value - currentYear
            return Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self)

        default:
            return Calendar.current.date(bySetting: component, value: value, of: self)
        }
    }
    // swiftlint:enable cyclomatic_complexity, function_body_length

    /// 重置时间到起始
    ///
    /// 	let date = Date() // "Jan 12, 2017, 7:14 PM"
    /// 	let date2 = date.beginning(of: .hour) // "Jan 12, 2017, 7:00 PM"
    /// 	let date3 = date.beginning(of: .month) // "Jan 1, 2017, 12:00 AM"
    /// 	let date4 = date.beginning(of: .year) // "Jan 1, 2017, 12:00 AM"
    ///
    /// - Parameter component: calendar component to get date at the beginning of.
    /// - Returns: date at the beginning of calendar component (if applicable).
    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return Calendar.current.startOfDay(for: self)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]

            case .minute:
                return [.year, .month, .day, .hour, .minute]

            case .hour:
                return [.year, .month, .day, .hour]

            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]

            case .month:
                return [.year, .month]

            case .year:
                return [.year]

            default:
                return []
            }
        }

        guard !components.isEmpty else { return nil }
        return Calendar.current.date(from: Calendar.current.dateComponents(components, from: self))
    }

    // swiftlint:disable function_body_length
    /// 重置时间到终止
    ///
    /// 	let date = Date() // "Jan 12, 2017, 7:27 PM"
    /// 	let date2 = date.end(of: .day) // "Jan 12, 2017, 11:59 PM"
    /// 	let date3 = date.end(of: .month) // "Jan 31, 2017, 11:59 PM"
    /// 	let date4 = date.end(of: .year) // "Dec 31, 2017, 11:59 PM"
    ///
    /// - Parameter component: calendar component to get date at the end of.
    /// - Returns: date at the end of calendar component (if applicable).
    func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = adding(.second, value: 1)
            date = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.add(.second, value: -1)
            return date

        case .minute:
            var date = adding(.minute, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .hour:
            var date = adding(.hour, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .day:
            var date = adding(.day, value: 1)
            date = Calendar.current.startOfDay(for: date)
            date.add(.second, value: -1)
            return date

        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = Calendar.current.date(from:
                Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date

        case .month:
            var date = adding(.month, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .year:
            var date = adding(.year, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year], from: date))!
            date = after.adding(.second, value: -1)
            return date

        default:
            return nil
        }
    }
    // swiftlint:enable function_body_length

    /// 检查日期是否在当前给定的日历范围中。
    ///
    /// 	Date().isInCurrent(.day) -> true
    /// 	Date().isInCurrent(.year) -> true
    ///
    /// - Parameter component: calendar component to check.
    /// - Returns: true if date is in current given calendar component.
    func isInCurrent(_ component: Calendar.Component) -> Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: component)
    }

    /// 日期字符串 指定format
    ///
    ///     Date().string(withFormat: "dd/MM/yyyy") -> "1/12/17"
    ///     Date().string(withFormat: "HH:mm") -> "23:50"
    ///     Date().string(withFormat: "dd/MM/yyyy HH:mm") -> "1/12/17 23:50"
    ///
    /// - Parameter format: Date format (default is "dd/MM/yyyy").
    /// - Returns: date string.
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    /// 日期字符串.指定style
    ///
    /// 	Date().dateString(ofStyle: .short) -> "1/12/17"
    /// 	Date().dateString(ofStyle: .medium) -> "Jan 12, 2017"
    /// 	Date().dateString(ofStyle: .long) -> "January 12, 2017"
    /// 	Date().dateString(ofStyle: .full) -> "Thursday, January 12, 2017"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: date string.
    func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }

    /// 日期时间字符串 指定style
    ///
    /// 	Date().dateTimeString(ofStyle: .short) -> "1/12/17, 7:32 PM"
    /// 	Date().dateTimeString(ofStyle: .medium) -> "Jan 12, 2017, 7:32:00 PM"
    /// 	Date().dateTimeString(ofStyle: .long) -> "January 12, 2017 at 7:32:00 PM GMT+3"
    /// 	Date().dateTimeString(ofStyle: .full) -> "Thursday, January 12, 2017 at 7:32:00 PM GMT+03:00"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: date and time string.
    func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }

    /// 时间字符串 指定style
    ///
    /// 	Date().timeString(ofStyle: .short) -> "7:37 PM"
    /// 	Date().timeString(ofStyle: .medium) -> "7:37:02 PM"
    /// 	Date().timeString(ofStyle: .long) -> "7:37:02 PM GMT+3"
    /// 	Date().timeString(ofStyle: .full) -> "7:37:02 PM GMT+03:00"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: time string.
    func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: self)
    }

    /// 某天的名字，是否缩写
    ///
    /// 	Date().dayName(ofStyle: .oneLetter) -> "T"
    /// 	Date().dayName(ofStyle: .threeLetters) -> "Thu"
    /// 	Date().dayName(ofStyle: .full) -> "Thursday"
    ///
    /// - Parameter Style: style of day name (default is DayNameStyle.full).
    /// - Returns: day name string (example: W, Wed, Wednesday).
    func dayName(ofStyle style: DayNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:
                return "EEEEE"
            case .threeLetters:
                return "EEE"
            case .full:
                return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }

    /// 某月的名字
    ///
    /// 	Date().monthName(ofStyle: .oneLetter) -> "J"
    /// 	Date().monthName(ofStyle: .threeLetters) -> "Jan"
    /// 	Date().monthName(ofStyle: .full) -> "January"
    ///
    /// - Parameter Style: style of month name (default is MonthNameStyle.full).
    /// - Returns: month name string (example: D, Dec, December).
    func monthName(ofStyle style: MonthNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:
                return "MMMMM"
            case .threeLetters:
                return "MMM"
            case .full:
                return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }

    /// 两个日期之间的差值 单位秒
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of seconds between self and given date.
    func secondsSince(_ date: Date) -> Double {
        return timeIntervalSince(date)
    }

    /// 两个日期之间的差值 单位分钟
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of minutes between self and given date.
    func minutesSince(_ date: Date) -> Double {
        return timeIntervalSince(date)/60
    }

    /// 两个日期之间的差值 单位小时
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of hours between self and given date.
    func hoursSince(_ date: Date) -> Double {
        return timeIntervalSince(date)/3600
    }

    /// 两个日期之间的差值 单位天
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of days between self and given date.
    func daysSince(_ date: Date) -> Double {
        return timeIntervalSince(date)/(3600*24)
    }

    ///监测日期是否在两个日期之内
    ///
    /// - Parameters:
    ///   - startDate: start date to compare self to.
    ///   - endDate: endDate date to compare self to.
    ///   - includeBounds: true if the start and end date should be included (default is false)
    /// - Returns: true if the date is between the two given dates.
    func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0
        }
        return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
    }

    /// 检查一个日期是否是另一个日期的若干个日期组成部分
    ///
    /// - Parameters:
    ///   - value: number of times component is used in creating range
    ///   - component: Calendar.Component to use.
    ///   - date: Date to compare self to.
    /// - Returns: true if the date is within a number of components of another date
    func isWithin(_ value: UInt, _ component: Calendar.Component, of date: Date) -> Bool {
        let components = Calendar.current.dateComponents([component], from: self, to: date)
        let componentValue = components.value(for: component)!
        return abs(componentValue) <= value
    }

    /// 返回指定范围内的随机日期。
    ///
    /// - Parameter range: The range in which to create a random date. `range` must not be empty.
    /// - Returns: A random date within the bounds of `range`.
    static func random(in range: Range<Date>) -> Date {
        return Date(timeIntervalSinceReferenceDate:
            TimeInterval.random(in: range.lowerBound.timeIntervalSinceReferenceDate..<range.upperBound.timeIntervalSinceReferenceDate))
    }

    /// 返回指定范围内的随机日期。
    ///
    /// - Parameter range: The range in which to create a random date.
    /// - Returns: A random date within the bounds of `range`.
    static func random(in range: ClosedRange<Date>) -> Date {
        return Date(timeIntervalSinceReferenceDate:
            TimeInterval.random(in: range.lowerBound.timeIntervalSinceReferenceDate...range.upperBound.timeIntervalSinceReferenceDate))
    }

    /// 使用给定生成器作为随机源，返回指定范围内的随机日期。
    ///
    /// - Parameters:
    ///   - range: The range in which to create a random date. `range` must not be empty.
    ///   - generator: The random number generator to use when creating the new random date.
    /// - Returns: A random date within the bounds of `range`.
    static func random<T>(in range: Range<Date>, using generator: inout T) -> Date where T: RandomNumberGenerator {
        return Date(timeIntervalSinceReferenceDate:
            TimeInterval.random(in: range.lowerBound.timeIntervalSinceReferenceDate..<range.upperBound.timeIntervalSinceReferenceDate,
                                using: &generator))
    }

    /// 使用给定生成器作为随机源，返回指定范围内的随机日期.
    ///
    /// - Parameters:
    ///   - range: The range in which to create a random date.
    ///   - generator: The random number generator to use when creating the new random date.
    /// - Returns: A random date within the bounds of `range`.
    static func random<T>(in range: ClosedRange<Date>, using generator: inout T) -> Date where T: RandomNumberGenerator {
        return Date(timeIntervalSinceReferenceDate:
            TimeInterval.random(in: range.lowerBound.timeIntervalSinceReferenceDate...range.upperBound.timeIntervalSinceReferenceDate,
                                using: &generator))
    }

}

// MARK: - Initializers
public extension Date {

    /// 根据calendar创建Date
    ///
    /// 	let date = Date(year: 2010, month: 1, day: 12) // "Jan 12, 2010, 7:45 PM"
    ///
    /// - Parameters:
    ///   - calendar: Calendar (default is current).
    ///   - timeZone: TimeZone (default is current).
    ///   - era: Era (default is current era).
    ///   - year: Year (default is current year).
    ///   - month: Month (default is current month).
    ///   - day: Day (default is today).
    ///   - hour: Hour (default is current hour).
    ///   - minute: Minute (default is current minute).
    ///   - second: Second (default is current second).
    ///   - nanosecond: Nanosecond (default is current nanosecond).
    init?(
        calendar: Calendar? = Calendar.current,
        timeZone: TimeZone? = TimeZone.current,
        era: Int? = Date().era,
        year: Int? = Date().year,
        month: Int? = Date().month,
        day: Int? = Date().day,
        hour: Int? = Date().hour,
        minute: Int? = Date().minute,
        second: Int? = Date().second,
        nanosecond: Int? = Date().nanosecond) {

        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond

        if let date = calendar?.date(from: components) {
            self = date
        } else {
            return nil
        }
    }

    /// 从  ISO8601 string创建日期
    ///
    /// 	let date = Date(iso8601String: "2017-01-12T16:48:00.959Z") // "Jan 12, 2017, 7:48 PM"
    ///
    /// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
    init?(iso8601String: String) {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: iso8601String) {
            self = date
        } else {
            return nil
        }
    }

    /// 从 UNIX timestamp创建日期
    ///
    /// 	let date = Date(unixTimestamp: 1484239783.922743) // "Jan 12, 2017, 7:49 PM"
    ///
    /// - Parameter unixTimestamp: UNIX timestamp.
    init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }

    /// 从 Int literal创建日期
    ///
    ///     let date = Date(integerLiteral: 2017_12_25) // "2017-12-25 00:00:00 +0000"
    /// - Parameter value: Int value, e.g. 20171225, or 2017_12_25 etc.
    init?(integerLiteral value: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date = formatter.date(from: String(value)) else { return nil }
        self = date
    }

}
#endif
