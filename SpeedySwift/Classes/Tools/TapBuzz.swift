//
//  TapBuzz.swift
//  SpeedySwift
//
//  Created by Quinn on 2020/3/21.
//  Copyright © 2020 Better. All rights reserved.
//
/// 振动反馈
public class TapBuzz{
    public static func light() {
        TapticEngine.impact.feedback(.light)
    }

    public static func medium() {
        TapticEngine.impact.feedback(.medium)
    }

    public static func heavy() {
        TapticEngine.impact.feedback(.heavy)
    }

    public static func selection() {
        TapticEngine.selection.feedback()
    }

    public static func success() {
        TapticEngine.notification.feedback(.success)
    }

    public static func warning() {
        TapticEngine.notification.feedback(.warning)
    }

    public static func error() {
        TapticEngine.notification.feedback(.error)
    }
}

