//
//  SignedIntegerExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/15/17.
//  Copyright © 2017 SpeedySwift
//
#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension SignedInteger {

    /// 绝对值
    public var abs: Self {
        return Swift.abs(self)
    }

    /// 是否正数
    public var isPositive: Bool {
        return self > 0
    }

    /// 是否负数
    public var isNegative: Bool {
        return self < 0
    }

    /// 是否偶数
    public var isEven: Bool {
        return (self % 2) == 0
    }

    /// 是否奇数
    public var isOdd: Bool {
        return (self % 2) != 0
    }

    /// 秒转时分
    public var timeString: String {
        guard self > 0 else {
            return "0 sec"
        }
        if self < 60 {
            return "\(self) sec"
        }
        if self < 3600 {
            return "\(self / 60) min"
        }
        let hours = self / 3600
        let mins = (self % 3600) / 60

        if hours != 0 && mins == 0 {
            return "\(hours)h"
        }
        return "\(hours)h \(mins)m"
    }

}

// MARK: - Methods
public extension SignedInteger {

    // swiftlint:disable next identifier_name
    /// 与n的最大公约数。
    ///
    /// - Parameter n: integer value to find gcd with.
    /// - Returns: greatest common divisor of self and n.
    public func gcd(of n: Self) -> Self {
        return n == 0 ? self : n.gcd(of: self % n)
    }

    // swiftlint:disable next identifier_name
    /// 和n的最小公倍数。
    ///
    /// - Parameter n: integer value to find lcm with.
    /// - Returns: least common multiple of self and n.
    public func lcm(of n: Self) -> Self {
        return (self * n).abs / gcd(of: n)
    }

    #if canImport(Foundation)
    /// 整数的序数表示法。第几
    ///
    ///        print((12).ordinalString()) // prints "12th"
    ///
    /// - Parameter locale: locale, default is .current.
    /// - Returns: string ordinal representation of number in specified locale language. E.g. input 92, output in "en": "92nd".
    @available(iOS 9.0, macOS 10.11, *)
    public func ordinalString(locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .ordinal
        guard let number = self as? NSNumber else { return nil }
        return formatter.string(from: number)
    }
    #endif

}
