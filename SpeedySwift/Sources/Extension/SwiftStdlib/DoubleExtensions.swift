//
//  DoubleExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/6/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

// MARK: - Properties
public extension Double {

    ///转int
    public var int: Int {
        return Int(self)
    }

    /// 转float
    public var float: Float {
        return Float(self)
    }

    #if canImport(CoreGraphics)
    /// 转CGFloat
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif

}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// 指数函数
///
/// - Parameters:
///   - lhs: base double.
///   - rhs: exponent double.
/// - Returns: exponentiation result (example: 4.4 ** 0.5 = 2.0976176963).
public func ** (lhs: Double, rhs: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

// swiftlint:disable next identifier_name
prefix operator √
/// 平方根
///
/// - Parameter double: double value to find square root for.
/// - Returns: square root of given double.
public prefix func √ (double: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return sqrt(double)
}
