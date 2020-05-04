//
//  Floatpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/8/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

// MARK: - Properties
public extension Float {

    /// 转int
    var  int: Int {
        return Int(self)
    }

    /// 转double
    var  double: Double {
        return Double(self)
    }

    #if canImport(CoreGraphics)
    /// 转CGFloat
    var  cgFloat: CGFloat {
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
///   - lhs: base float.
///   - rhs: exponent float.
/// - Returns: exponentiation result (4.4 ** 0.5 = 2.0976176963).
func ** (lhs: Float, rhs: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

// swiftlint:disable next identifier_name
prefix operator √
///  平方根
///
/// - Parameter float: float value to find square root for
/// - Returns: square root of given float.
prefix func √ (float: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return sqrt(float)
}
