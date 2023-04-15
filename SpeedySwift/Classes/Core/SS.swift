//
//  Screen.swift
//  SSSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
/*
 到 2021 年的现在这个时间点，iPhone 的逻辑分辨率宽度进化到了
 320pt（非全面屏）、
 375pt（非全面屏）、
 414pt（非全面屏、全面屏）、
 390pt（全面屏）、
 428pt（全面屏）
 
 对于手机来讲，非全面的手机高度一定小于 736，全面屏的一定大于780
 参考：https://juejin.cn/post/6968336931776102414
 */
public typealias SS = SpeedySwift
@objcMembers
public class SpeedySwift:NSObject {
    
    public static let shared = SpeedySwift()
    public static let lock = DispatchSemaphore(value: 1)
    
    public let w = UIScreen.main.bounds.width
    public let h = UIScreen.main.bounds.height
    public let bounds = UIScreen.main.bounds
    
    public var openLog = false
    
    private override init() {}
    
    
    public static var w = UIScreen.main.bounds.width
    public static var h = UIScreen.main.bounds.height
    /// app 显示名称
    public static var displayName: String {
        // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "SpeedySwift"
    }
    
    /// app 的bundleid
    public static var bundleID: String {
        return Bundle.main.bundleIdentifier ?? "top.tlien.ss"
    }
    
    /// build号
    public static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? "1"
    }
    
    /// app版本号
    public static var versionS: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    /// 设备名称
    public static var deviceName: String {
        return UIDevice.current.localizedModel
    }
    /// 设备方向 有时会取到未知unknown
    public static var deviceOrientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    public static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    /// 主窗口
    public static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }
    /// 当前系统版本
    public static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    /// 判断设备是不是iPhoneX
    public var isX : Bool {
        return SS.shared.h > 750
    }
    /// TableBar距底部区域高度
    public var safeBottomHeight : CGFloat {
        var bottomH : CGFloat = 0.0
        if isX {
            bottomH = 34.0
        }
        return bottomH
    }
    
    /// 状态栏的高度
    public var topSafeAreaHeight : CGFloat {
        let window = UIApplication.shared.keyWindow
        let topSafeAreaHeight = window?.safeAreaInsets.top ?? 0
        return topSafeAreaHeight
    }
    
    /// 左边安全距
    public var leftSafeAreaWidth : CGFloat {
        let window = UIApplication.shared.keyWindow
        let topSafeAreaHeight = window?.safeAreaInsets.left ?? 0
        return topSafeAreaHeight
    }
    /// 右边安全距
    public var rightSafeAreaWidth : CGFloat {
        let window = UIApplication.shared.keyWindow
        let topSafeAreaHeight = window?.safeAreaInsets.right ?? 0
        return topSafeAreaHeight
    }
    
    /// 导航栏的高度
    public static var navBarHeight: CGFloat {
        return 44.0
    }
    
    /// tabbar的高度
    public static var tabBarHeight: CGFloat {
        return 49.0
    }
    
    /// 状态栏和导航栏的高度
    public static var statusWithNavBarHeight : CGFloat {
        let heigth = SS.shared.topSafeAreaHeight + navBarHeight
        return heigth
    }
    /// 根据宽度缩放
    public static func scaleW(_ width: CGFloat,fit:CGFloat = 375.0) -> CGFloat {
        return SS.shared.w / fit * width
    }
    /// 根据高度缩放
    public static func scaleH(_ height: CGFloat,fit:CGFloat = 812.0) -> CGFloat {
        return SS.shared.h / fit * height
    }
    /// 默认根据宽度缩放
    public static func scale(_ value: CGFloat) -> CGFloat {
        return scaleW(value)
    }
    /// 根据控制器获取 顶层控制器
    public static func topVC(_ viewController: UIViewController?) -> UIViewController? {
        guard let currentVC = viewController else {
            return nil
        }
        if let nav = currentVC as? UINavigationController {
            // 控制器是nav
            return topVC(nav.visibleViewController)
        } else if let tabC = currentVC as? UITabBarController {
            // tabBar 的跟控制器
            return topVC(tabC.selectedViewController)
        } else if let presentVC = currentVC.presentedViewController {
            //modal出来的 控制器
            return topVC(presentVC)
        } else {
            // 返回顶控制器
            return currentVC
        }
    }
    /// 顶层控制器的navigationController
    public static var topNavVC: UINavigationController? {
        if let topVC = self.topVC() {
            if let nav = topVC.navigationController {
                return nav
            } else {
                return SSNavigationController(rootViewController: topVC)
            }
        }
        return nil
    }
    /// 获取顶层控制器 根据window
    public static func topVC() -> UIViewController? {
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return topVC(vc)
    }
    /// window 的 toast
    public static func toast(message:String,duration: TimeInterval  = 1){
        if let view = UIApplication.shared.keyWindow{
            view.toast(message: message,duration: duration)
        }
    }
    /// 当用户截屏时的监听
    public static func didTakeScreenShot(_ action: @escaping (_ notification: Notification) -> Void) {
        // http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
        _ = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification,
                                                   object: nil,
                                                   queue: OperationQueue.main) { notification in
                                                    action(notification)
        }
    }
    /// 主动崩溃
    public static func exitApp(){
        /// 这是默认的程序结束函数,
        abort()
    }
}
