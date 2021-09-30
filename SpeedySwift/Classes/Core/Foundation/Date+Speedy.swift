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
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: self)
        return date
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