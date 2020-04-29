//
//  CGPointExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 07/12/2016.
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

// MARK: - 方法
public extension CGPoint {

    /// 两个点的距离
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let point2 = CGPoint(x: 30, y: 30)
    ///     let distance = point1.distance(from: point2)
    ///     //distance = 28.28
    ///
    /// - Parameter point: 相对点
    /// - Returns: 自己和另一个点的距离
    public func distance(from point: CGPoint) -> CGFloat {
        return CGPoint.distance(from: self, to: point)
    }

    /// 两个点的距离
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let point2 = CGPoint(x: 30, y: 30)
    ///     let distance = CGPoint.distance(from: point2, to: point1)
    ///     //Distance = 28.28
    ///
    /// - Parameters:
    ///   - point1: 第一个点
    ///   - point2: 第二个点
    /// - Returns: 两个点之间的距离
    public static func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        // http://stackoverflow.com/questions/6416101/calculate-the-distance-between-two-cgpoints
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }

}

// MARK: - 操作符
public extension CGPoint {

    /// 两个点相加
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let point2 = CGPoint(x: 30, y: 30)
    ///     let point = point1 + point2
    ///     //point = CGPoint(x: 40, y: 40)
    ///
    /// - Parameters:
    ///   - lhs: CGPoint to add to.
    ///   - rhs: CGPoint to add.
    /// - Returns: 给定的两个点相加的结果
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /// CGPoint 加等
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let point2 = CGPoint(x: 30, y: 30)
    ///     point1 += point2
    ///     //point1 = CGPoint(x: 40, y: 40)
    ///
    /// - Parameters:
    ///   - lhs: 本身
    ///   - rhs: 叠加的点.
    public static func += (lhs: inout CGPoint, rhs: CGPoint) {
        // swiftlint:disable next shorthand_operator
        lhs = lhs + rhs
    }

    /// 两个点相减
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let point2 = CGPoint(x: 30, y: 30)
    ///     let point = point1 - point2
    ///     //point = CGPoint(x: -20, y: -20)
    ///
    /// - Parameters:
    ///   - lhs: 被减数
    ///   - rhs: 减数
    /// - Returns: result of subtract of the two given CGPoints.
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    /// CGPoint 减等
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let point2 = CGPoint(x: 30, y: 30)
    ///     point1 -= point2
    ///     //point1 = CGPoint(x: -20, y: -20)
    ///
    /// - Parameters:
    ///   - lhs: 本身
    ///   - rhs: 减数
    public static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        // swiftlint:disable next shorthand_operator
        lhs = lhs - rhs
    }

    /// CGPoint 乘法
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let scalar = point1 * 5
    ///     //scalar = CGPoint(x: 50, y: 50)
    ///
    /// - Parameters:
    ///   - point: CGPoint to multiply.
    ///   - scalar: scalar value.
    /// - Returns: result of multiplication of the given CGPoint with the scalar.
    public static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    /// CGPoint 乘等
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     point *= 5
    ///     //point1 = CGPoint(x: 50, y: 50)
    ///
    /// - Parameters:
    ///   - point: self.
    ///   - scalar: scalar value.
    /// - Returns: result of multiplication of the given CGPoint with the scalar.
    public static func *= (point: inout CGPoint, scalar: CGFloat) {
        // swiftlint:disable next shorthand_operator
        point = point * scalar
    }

    /// CGPoint 缩放
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let scalar = 5 * point1
    ///     //scalar = CGPoint(x: 50, y: 50)
    ///
    /// - Parameters:
    ///   - scalar: scalar value.
    ///   - point: CGPoint to multiply.
    /// - Returns: result of multiplication of the given CGPoint with the scalar.
    public static func * (scalar: CGFloat, point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

}
#endif
