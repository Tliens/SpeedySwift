//
//  SpeedyJump.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/5/4.
//  Copyright © 2020 Quinn Von. All rights reserved.
//

import UIKit

/// 跳转到具体的App，常用软件
public enum SpeedyJumpAppType:String{
    /// 微信
    case wechat = "weixin://"
    /// QQ
    case qq = "mqq://"
    /// 电话
    case phone = "mobilephone://"
}
/// 跳转状态 是否成功
public enum SpeedyJumpStatus: String {
    case success    = "success"
    case fail        = "fail"
    init?(string: String?) {
        guard let string = string else { return nil }
        self.init(rawValue: string)
    }
}
/// JMPStatus  描述信息
extension SpeedyJumpStatus: CustomStringConvertible {
    public var description: String {
        return rawValue
    }
}
