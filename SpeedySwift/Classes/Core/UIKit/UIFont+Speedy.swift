//
//  UIFont+Speedy.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
extension UIFont{
    public class func sc_regular(size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    public class func sc_semibold(size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    public class func sc_medium(size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
