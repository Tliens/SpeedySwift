//
//  SpeedyJump.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/5/4.
//  Copyright © 2020 Quinn Von. All rights reserved.
//

import UIKit

/// 跳转到具体的App，常用软件
enum AppJumpAppType:String{
    /// 微信
    case wechat = "weixin://"
    /// QQ
    case qq = "mqq://"
    /// 电话
    case phone = "mobilephone://"
}
/// 跳转状态 是否成功
enum AppJumpStatus: String {
    case success    = "success"
    case fail        = "fail"
    init?(string: String?) {
        guard let string = string else { return nil }
        self.init(rawValue: string)
    }
}
/// JMPStatus  描述信息
extension AppJumpStatus: CustomStringConvertible {
    public var description: String {
        return rawValue
    }
}

extension App{
    /// 跳转到系统页面
    /// - Parameter type： 类型
    /// - Parameter completionHandler：  block回调，bool表示是否成功
    static func systemJump(completionHandler completion: ((AppJumpStatus) -> Void)? = nil){
        let urlString = UIApplication.openSettingsURLString
        if let url: URL = URL(string: urlString) {
            App.jump(url: url, completionHandler: completion)
        }else{
            completion?(.fail)
        }
    }
    
    /// 跳转到App
    /// - Parameter type： 类型
    /// - Parameter completionHandler：  block回调，bool表示是否成功
    static func appJump(type:AppJumpAppType, completionHandler completion: ((AppJumpStatus) -> Void)? = nil){
        if let url: URL = URL(string: type.rawValue) {
            App.jump(url: url, completionHandler: completion)
        }else{
            completion?(.fail)
        }
    }
    
    /// 跳转
    static func jump(url:URL, completionHandler completion: ((AppJumpStatus) -> Void)? = nil){
        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:]) { (bool) in
                if bool{
                    completion?(.success)
                }else{
                    completion?(.fail)
                }
            }
        }
    }
}
