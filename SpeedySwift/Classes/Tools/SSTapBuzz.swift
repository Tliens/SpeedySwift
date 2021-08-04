//
//  SSTapBuzz.swift
//  SpeedySwift
//
//  Created by Quinn on 2020/3/21.
//  Copyright © 2020 Better. All rights reserved.
//
/// 振动反馈
public extension SS{
    static let buzz = SSTapBuzz.self
}
public class SSTapBuzz{
    public static func light() {
        SSTapticEngine.impact.feedback(.light)
    }

    public static func medium() {
        SSTapticEngine.impact.feedback(.medium)
    }

    public static func heavy() {
        SSTapticEngine.impact.feedback(.heavy)
    }

    public static func selection() {
        SSTapticEngine.selection.feedback()
    }

    public static func success() {
        SSTapticEngine.notification.feedback(.success)
    }

    public static func warning() {
        SSTapticEngine.notification.feedback(.warning)
    }

    public static func error() {
        SSTapticEngine.notification.feedback(.error)
    }
}

