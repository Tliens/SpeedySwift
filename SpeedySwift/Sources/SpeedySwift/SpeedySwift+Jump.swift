//
//  SpeedySwift+Jump.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/5/4.
//  Copyright © 2020 Quinn Von. All rights reserved.
//

import UIKit

extension SpeedySwift{
    /// 跳转到系统页面
    /// - Parameter type： 类型
    /// - Parameter completionHandler：  block回调，bool表示是否成功
    static func systemJump(completionHandler completion: ((SpeedyJumpStatus) -> Void)? = nil){
        let urlString = UIApplication.openSettingsURLString
        if let url: URL = URL(string: urlString) {
            SpeedySwift.jump(url: url, completionHandler: completion)
        }else{
            completion?(.fail)
        }
    }
    
    /// 跳转到App
    /// - Parameter type： 类型
    /// - Parameter completionHandler：  block回调，bool表示是否成功
    static func appJump(type:SpeedyJumpAppType, completionHandler completion: ((SpeedyJumpStatus) -> Void)? = nil){
        if let url: URL = URL(string: type.rawValue) {
            SpeedySwift.jump(url: url, completionHandler: completion)
        }else{
            completion?(.fail)
        }
    }
    
    /// 跳转
    static func jump(url:URL, completionHandler completion: ((SpeedyJumpStatus) -> Void)? = nil){
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
