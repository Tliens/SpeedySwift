//
//  IntExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/6/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

// MARK: - Properties
public extension Int {

    /// 0..<self 的范围
    public var countableRange: CountableRange<Int> {
        return 0..<self
    }

    /// 弧度转角度
    public var degreesToRadians: Double {
        return Double.pi * Double(self) / 180.0
    }

    /// 角度转弧度
    public var radiansToDegrees: Double {
        return Double(self) * 180 / Double.pi
    }

    /// 转UInt
    public var uInt: UInt {
        return UInt(self)
    }

    /// 转double
    public var double: Double {
        return Double(self)
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

    /// 以千为单位 比如 1022 ->10k
    public var kFormatted: String {
        var sign: String {
            return self >= 0 ? "" : "-"
        }
        let abs = Swift.abs(self)
        if abs == 0 {
            return "0k"
        } else if abs >= 0 && abs < 1000 {
            return "0k"
        } else if abs >= 1000 && abs < 1000000 {
            return String(format: "\(sign)%ik", abs / 1000)
        }
        return String(format: "\(sign)%ikk", abs / 100000)
    }

    /// 整数转数字 如：103 -> [1,0,3]
    public var digits: [Int] {
        guard self != 0 else { return [0] }
        var digits = [Int]()
        var number = abs

        while number != 0 {
            let xNumber = number % 10
            digits.append(xNumber)
            number /= 10
        }

        digits.reverse()
        return digits
    }

    /// 有几位数字 如1000 一共是4位
    public var digitsCount: Int {
        guard self != 0 else { return 1 }
        let number = Double(abs)
        return Int(log10(number) + 1)
    }

}

// MARK: - Methods
public extension Int {

    /// 是否为素数。
    /// Warning: Using big numbers can be computationally expensive!
    /// - Returns: true or false depending on prime-ness
    public func isPrime() -> Bool {
        // To improve speed on latter loop :)
        if self == 2 {
            return true
        }

        guard self > 1 && self % 2 != 0 else {
            return false
        }
        // Explanation: It is enough to check numbers until
        // the square root of that number. If you go up from N by one,
        // other multiplier will go 1 down to get similar result
        // (integer-wise operation) such way increases speed of operation
        let base = Int(sqrt(Double(self)))
        for int in Swift.stride(from: 3, through: base, by: 2) where self % int == 0 {
            return false
        }
        return true
    }

    /// 转罗马数字
    ///
    ///10.romanNumeral() -> "X"
    ///
    /// - Returns: The roman numeral string.
    public func romanNumeral() -> String? {
        // https://gist.github.com/kumo/a8e1cb1f4b7cff1548c7
        guard self > 0 else { // there is no roman numerals for 0 or negative numbers
            return nil
        }
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]

        var romanValue = ""
        var startingValue = self

        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue
            if div > 0 {
                for _ in 0..<div {
                    romanValue += romanChar
                }
                startingValue -= arabicValue * div
            }
        }
        return romanValue
    }

    // swiftlint:disable next identifier_name
    /// 四舍五入到最接近的n的倍数
    public func roundToNearest(_ n: Int) -> Int {
        return n == 0 ? self : Int(round(Double(self) / Double(n))) * n
    }

}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// 指数函数
///
/// - Parameters:
///   - lhs: base integer.
///   - rhs: exponent integer.
/// - Returns: exponentiation result (example: 2 ** 3 = 8).
public func ** (lhs: Int, rhs: Int) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(Double(lhs), Double(rhs))
}

// swiftlint:disable next identifier_name
prefix operator √
/// 平方根
///
/// - Parameter int: integer value to find square root for
/// - Returns: square root of given integer.
public prefix func √ (int: Int) -> Double {
    // http://nshipster.com/swift-operators/
    return sqrt(Double(int))
}

// swiftlint:disable next identifier_name
infix operator ±
/// 误差范围 自身为原点
///
/// - Parameters:
///   - lhs: integer number.
///   - rhs: integer number.
/// - Returns: tuple of plus-minus operation (example: 2 ± 3 -> (5, -1)).
public func ± (lhs: Int, rhs: Int) -> (Int, Int) {
    // http://nshipster.com/swift-operators/
    return (lhs + rhs, lhs - rhs)
}

// swiftlint:disable next identifier_name
prefix operator ±
/// 误差范围，0为原点
///
/// - Parameter int: integer number
/// - Returns: tuple of plus-minus operation (example: ± 2 -> (2, -2)).
public prefix func ± (int: Int) -> (Int, Int) {
    // http://nshipster.com/swift-operators/
    return 0 ± int
}
