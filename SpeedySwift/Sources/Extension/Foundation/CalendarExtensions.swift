//
//  Calendarpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 09/11/17.
//  Copyright © 2017 SpeedySwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Methods
public extension Calendar {

    /// 当前日期所在月份有多少天
    ///
    ///		let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///		Calendar.current.numberOfDaysInMonth(for: date) -> 31
    ///
    /// - Parameter date: the date form which the number of days in month is calculated.
    /// - Returns: The number of days in the month of 'Date'.
    func numberOfDaysInMonth(for date: Date) -> Int {
        return range(of: .day, in: .month, for: date)!.count
    }

}
#endif
