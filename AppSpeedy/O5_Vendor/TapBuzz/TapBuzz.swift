//
//  TapBuzz.swift
//  TPlan
//
//  Created by Quinn on 2020/3/21.
//  Copyright © 2020 Better. All rights reserved.
//
/// 振动反馈
class TapBuzz{
    static func light() {
        TapticEngine.impact.feedback(.light)
    }

    static func medium() {
        TapticEngine.impact.feedback(.medium)
    }

    static func heavy() {
        TapticEngine.impact.feedback(.heavy)
    }

    static func selection() {
        TapticEngine.selection.feedback()
    }

    static func success() {
        TapticEngine.notification.feedback(.success)
    }

    static func warning() {
        TapticEngine.notification.feedback(.warning)
    }

    static func error() {
        TapticEngine.notification.feedback(.error)
    }
}

