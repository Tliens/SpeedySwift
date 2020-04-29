//
//  SpeedySwift.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

#if canImport(WatchKit)
import WatchKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

#if !os(Linux)
// MARK: - Properties
/// SpeedySwift: Common usefull properties and methods.
public struct SpeedySwift {

    #if !os(macOS)
    /// App 显示名称
    public static var appDisplayName: String? {
        // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }
    #endif

    #if !os(macOS)
    /// app 的bundleid
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }
    #endif

    #if os(iOS)
    /// 状态栏高度
    public static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    #endif

    #if !os(macOS)
    /// build号
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// 未读消息数量
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    #endif

    #if !os(macOS)
    /// app版本号
    public static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    #endif

    #if os(iOS)
    /// 当前电量等级
    public static var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// 当前设备
    public static var currentDevice: UIDevice {
        return UIDevice.current
    }
    #elseif os(watchOS)
    /// SpeedySwift: Shared instance of current device.
    public static var currentDevice: WKInterfaceDevice {
        return WKInterfaceDevice.current()
    }
    #endif

    #if !os(macOS)
    /// 屏幕高度
    public static var screenHeight: CGFloat {
        #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.height
        #elseif os(watchOS)
        return currentDevice.screenBounds.height
        #endif
    }
    #endif

    #if !os(macOS)
    /// SpeedySwift: Current device model.
    public static var deviceModel: String {
        return currentDevice.model
    }
    #endif

    #if !os(macOS)
    /// 设备名称
    public static var deviceName: String {
        return currentDevice.name
    }
    #endif

    #if os(iOS)
    /// 设备方向
    public static var deviceOrientation: UIDeviceOrientation {
        return currentDevice.orientation
    }
    #endif

    #if !os(macOS)
    /// 屏幕宽度
    public static var screenWidth: CGFloat {
        #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.width
        #elseif os(watchOS)
        return currentDevice.screenBounds.width
        #endif
    }
    #endif

    /// 是否是Debug模式
    public static var isInDebuggingMode: Bool {
        // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    #if !os(macOS)
    /// 是否是TestFlight
    public static var isInTestFlight: Bool {
        // http://stackoverflow.com/questions/12431994/detect-testflight
        return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
    }
    #endif

    #if os(iOS)
    /// 检查当前设备是否支持多任务处理
    public static var isMultitaskingSupported: Bool {
        return UIDevice.current.isMultitaskingSupported
    }
    #endif

    #if os(iOS)
    /// 当前网络行为知识状态
    public static var isNetworkActivityIndicatorVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }
    #endif

    #if os(iOS)
    /// 是否为ipad
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    #endif

    #if os(iOS)
    /// 是否为iphone
    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// 当前app是否注册了远程通知
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    #endif

    /// 检查是否运行在模拟器上
    public static var isRunningOnSimulator: Bool {
        // http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    #if os(iOS)
    /// 状态栏显示隐藏
    public static var isStatusBarHidden: Bool {
        get {
            return UIApplication.shared.isStatusBarHidden
        }
        set {
            UIApplication.shared.isStatusBarHidden = newValue
        }
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// 主窗口
    public static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// 最顶层视图控制器(如果适用)。
    public static var mostTopViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set {
            UIApplication.shared.keyWindow?.rootViewController = newValue
        }
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// SpeedySwift: Shared instance UIApplication.
    public static var sharedApplication: UIApplication {
        return UIApplication.shared
    }
    #endif

    #if os(iOS)
    /// 当前状态栏类型·
    public static var statusBarStyle: UIStatusBarStyle? {
        get {
            return UIApplication.shared.statusBarStyle
        }
        set {
            if let style = newValue {
                UIApplication.shared.statusBarStyle = style
            }
        }
    }
    #endif

    #if !os(macOS)
    /// 当前系统版本
    public static var systemVersion: String {
        return currentDevice.systemVersion
    }
    #endif

}

// MARK: - Methods
public extension SpeedySwift {

    /// 延迟执行
    ///
    /// - Parameters:
    ///   - milliseconds: execute closure after the given delay.
    ///   - queue: a queue that completion closure should be executed on (default is DispatchQueue.main).
    ///   - completion: closure to be executed after delay.
    ///   - Returns: DispatchWorkItem task. You can call .cancel() on it to cancel delayed execution.
    @discardableResult public static func delay(milliseconds: Double, queue: DispatchQueue = .main, completion: @escaping () -> Void) -> DispatchWorkItem {
        let task = DispatchWorkItem { completion() }
        queue.asyncAfter(deadline: .now() + (milliseconds/1000), execute: task)
        return task
    }

    /// 延迟执行
    ///
    /// - Parameters:
    ///   - millisecondsOffset: allow execution of method if it was not called since millisecondsOffset.
    ///   - queue: a queue that action closure should be executed on (default is DispatchQueue.main).
    ///   - action: closure to be executed in a debounced way.
    public static func debounce(millisecondsDelay: Int, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
        // http://stackoverflow.com/questions/27116684/how-can-i-debounce-a-method-call
        var lastFireTime = DispatchTime.now()
        let dispatchDelay = DispatchTimeInterval.milliseconds(millisecondsDelay)
        let dispatchTime: DispatchTime = lastFireTime + dispatchDelay
        return {
            queue.asyncAfter(deadline: dispatchTime) {
                let when: DispatchTime = lastFireTime + dispatchDelay
                let now = DispatchTime.now()
                if now.rawValue >= when.rawValue {
                    lastFireTime = DispatchTime.now()
                    action()
                }
            }
        }
    }

    #if os(iOS) || os(tvOS)
    /// 当用户截屏时的监听
    ///
    /// - Parameter action: a closure to run when user takes a screenshot
    public static func didTakeScreenShot(_ action: @escaping (_ notification: Notification) -> Void) {
        // http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
        _ = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification,
                                                   object: nil,
                                                   queue: OperationQueue.main) { notification in
                                                    action(notification)
        }
    }
    #endif

    /// 类名
    ///
    /// - Parameter object: Any object to find its class name.
    /// - Returns: Class name for given object.
    public static func typeName(for object: Any) -> String {
        let objectType = type(of: object.self)
        return String.init(describing: objectType)
    }

}
#endif
