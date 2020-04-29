//
//  CGFloatExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/23/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Properties
public extension CGFloat {

    /// CGFloat 绝对值
    public var abs: CGFloat {
        return Swift.abs(self)
    }

    /// CGFloat向上取整
    public var ceil: CGFloat {
        return Foundation.ceil(self)
    }

    /// 度数转 弧度
    public var degreesToRadians: CGFloat {
        return .pi * self / 180.0
    }

    /// CGFloat向下取整
    public var floor: CGFloat {
        return Foundation.floor(self)
    }

    /// 检验是否为正数
    public var isPositive: Bool {
        return self > 0
    }

    /// 检查是否为负数
    public var isNegative: Bool {
        return self < 0
    }

    /// 强转Int
    public var int: Int {
        return Int(self)
    }

    /// 强转float
    public var float: Float {
        return Float(self)
    }

    /// 强转double
    public var double: Double {
        return Double(self)
    }

    /// 弧度转角度
    public var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }

}
#endif
