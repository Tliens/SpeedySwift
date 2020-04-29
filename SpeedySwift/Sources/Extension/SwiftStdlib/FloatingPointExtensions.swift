//
//  FloatingPointExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 7/23/17.
//  Copyright © 2017 SpeedySwift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension FloatingPoint {

    /// 绝对值
    public var abs: Self {
        return Swift.abs(self)
    }

    /// 是否为正数
    public var isPositive: Bool {
        return self > 0
    }

    /// 是否为负数
    public var isNegative: Bool {
        return self < 0
    }

    #if canImport(Foundation)
    /// 向上取整
    public var ceil: Self {
        return Foundation.ceil(self)
    }
    #endif

    /// 度数转 弧度
    public var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }

    #if canImport(Foundation)
    /// 向下取整
    public var floor: Self {
        return Foundation.floor(self)
    }
    #endif

    /// 角度转弧度
    public var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }

}

// MARK: - Operators

// swiftlint:disable next identifier_name
infix operator ±
/// 误差范围 自身为原点
///
/// - Parameters:
///   - lhs: number
///   - rhs: number
/// - Returns: tuple of plus-minus operation ( 2.5 ± 1.5 -> (4, 1)).
public func ±<T: FloatingPoint> (lhs: T, rhs: T) -> (T, T) {
    // http://nshipster.com/swift-operators/
    return (lhs + rhs, lhs - rhs)
}

// swiftlint:disable next identifier_name
prefix operator ±
/// 误差范围 0为原点
///
/// - Parameter int: number
/// - Returns: tuple of plus-minus operation (± 2.5 -> (2.5, -2.5)).
public prefix func ±<T: FloatingPoint> (number: T) -> (T, T) {
    // http://nshipster.com/swift-operators/
    return 0 ± number
}
