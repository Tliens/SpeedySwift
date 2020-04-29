//
//  SpeedySwift+Feedback.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//
// MARK: 触感反馈
import UIKit

extension SS{
    static func light() {
        SpeedyTapticEngine.impact.feedback(.light)
    }

    static func medium() {
        SpeedyTapticEngine.impact.feedback(.medium)
    }

    static func heavy() {
        SpeedyTapticEngine.impact.feedback(.heavy)
    }

    static func selection() {
        SpeedyTapticEngine.selection.feedback()
    }

    static func success() {
        SpeedyTapticEngine.notification.feedback(.success)
    }

    static func warning() {
        SpeedyTapticEngine.notification.feedback(.warning)
    }

    static func error() {
        SpeedyTapticEngine.notification.feedback(.error)
    }
}
