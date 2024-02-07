//
//  Date+Speedy.swift
//  SpeedySwift
//
//  Created by Quinn on 2021/9/11.
//

import Foundation

public extension Date{
    /// 日期 -> 字符串
    func toString(dateFormat:String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh-CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: self)
        return date
    }
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    /// 根据date获取当前月一共有多少天
    func daysOfMonth()->Int{
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    /// 获得当前月的所有日期
    func datesOfMonth() -> [Date]{
        var rs:[Date] = []
        let numDays = daysOfMonth()
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        for item in 1...numDays {
            let newdate = Calendar.current.date(from: DateComponents(year: year, month: month, day: item))
            rs.append(newdate!)
        }
        return rs
    }
    
    /// 日期当天的起始
    func todayAtStart()->Date{
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        let day = Calendar.current.component(.day, from: self)
        let newdate = Calendar.current.date(from: DateComponents(year: year, month: month, day: day,hour:0,minute: 0,second: 0))
        return newdate!
    }
    /// 日期当天的结束
    func todayAtEnd()->Date{
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        let day = Calendar.current.component(.day, from: self)
        let newdate = Calendar.current.date(from: DateComponents(year: year, month: month, day: day,hour:23,minute: 59,second: 59))
        return newdate!
    }
    func day()->String{
        let x = NSCalendar.current.component(.day, from: self)
        return "\(x)"
    }
    func month()->String{
        let x = NSCalendar.current.component(.month, from: self)
        return "\(x)"
    }
    func year()->String{
        let x = NSCalendar.current.component(.year, from: self)
        return "\(x)"
    }
    /// 增加几周
    mutating func addWeek(n: Int = 1){
        let cal = NSCalendar.current
        self = cal.date(byAdding: .day, value: n * 7, to: self)!
    }
    /// 增加几个月
    mutating func addMonth(n: Int = 1){
        let cal = NSCalendar.current
        self = cal.date(byAdding: .month, value: n, to: self)!
    }
    /// 增加几年
    mutating func addYear(n: Int = 1){
        let cal = NSCalendar.current
        self =  cal.date(byAdding: .year, value: n, to: self)!
    }
    /// 增加几天
    mutating func addDay(n: Int = 1){
        let cal = NSCalendar.current
        self =  cal.date(byAdding: .day, value: n, to: self)!
    }
}
