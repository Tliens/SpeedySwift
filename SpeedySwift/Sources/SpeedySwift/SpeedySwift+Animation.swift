//
//  SpeedySwift+Animation.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//
// MARK: 动画
import Foundation
import UIKit
extension SS{
    static func hintAnimation(position:CGPoint) -> CAAnimation{
        return SS.fadeInOutWithMovedAndScaleAnimation(fromPosition: CGPoint(x: position.x, y: position.y+30),
        toPosition: position,
        inDelay: 0,
        inDuration: 0.15,
        inScaleFrom: 0.6,
        inScaleTo: 1,
        outDelay: 1.2,
        outDuration: 0.3,
        outScaleFrom:1,
        outScaleTo:0.9,
        outOpacityFrom: 1,
        outOpacityTo: 0)
    }
    /// 入：渐显 出：渐隐 伴随 位移、缩放
    /// - Parameters:
    ///   - fromPosition: 起始点
    ///   - toPosition: 终点
    ///   - inDelay: 延迟多久
    ///   - inDuration: 入场时间
    ///   - inScaleFrom: 入场缩放起始值
    ///   - inScaleTo: 入场缩放最终值
    ///   - outDelay: 出场延迟
    ///   - outDuration: 出场时间
    ///   - outScaleFrom: 出场缩放起始值
    ///   - outScaleTo: 出场缩放最终值
    ///   - outOpacityFrom: 出场透明度起始值
    ///   - outOpacityTo: 出场透明度最终值
    /// - Returns: 一个满足上述条件的CoreAnimation动画组
    static func fadeInOutWithMovedAndScaleAnimation(fromPosition:CGPoint, toPosition:CGPoint, inDelay: Double, inDuration: Double,inScaleFrom:Double, inScaleTo:Double ,outDelay: Double, outDuration: Double,outScaleFrom:Double, outScaleTo:Double, outOpacityFrom:Double, outOpacityTo:Double) -> CAAnimation {

        let fadeIn1 = CABasicAnimation(keyPath: "position")
        fadeIn1.duration = inDuration
        fadeIn1.beginTime = inDelay
        fadeIn1.fromValue = fromPosition
        fadeIn1.toValue = toPosition

        let fadeIn2 = CABasicAnimation(keyPath: "transform.scale")
        fadeIn2.duration = inDuration
        fadeIn2.beginTime = inDelay
        fadeIn2.fromValue = inScaleFrom
        fadeIn2.toValue = inScaleTo
        
        let fadeIn3 = CABasicAnimation(keyPath: "opacity")
        fadeIn3.duration = inDuration
        fadeIn3.beginTime = inDelay
        fadeIn3.fromValue = 0
        fadeIn3.toValue = 1
        
        let fadeOut1 = CABasicAnimation(keyPath: "transform.scale")
        fadeOut1.duration = outDuration
        fadeOut1.beginTime = outDelay
        fadeOut1.fromValue = outScaleFrom
        fadeOut1.toValue = outScaleTo
        
        let fadeOut2 = CABasicAnimation(keyPath: "opacity")
        fadeOut2.duration = outDuration
        fadeOut2.beginTime = outDelay
        fadeOut2.fromValue = outOpacityFrom
        fadeOut2.toValue = outOpacityTo
        
        let animateGroup = CAAnimationGroup()
        animateGroup.duration = outDelay + outDuration
        animateGroup.animations = [fadeIn1,fadeIn2,fadeIn3,fadeOut1,fadeOut2]
        animateGroup.fillMode = CAMediaTimingFillMode.forwards
        animateGroup.isRemovedOnCompletion = false
        return animateGroup
    }
}
