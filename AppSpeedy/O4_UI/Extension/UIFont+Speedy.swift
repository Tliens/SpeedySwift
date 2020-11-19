//
//  UIFont+Speedy.swift
//  WorldClock
//
//  Created by 2020 on 2020/10/20.
//

import UIKit
extension UIFont{
    class func sc_regular(size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    class func sc_semibold(size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    class func sc_medium(size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    class func arial(size:CGFloat)->UIFont{
        return UIFont(name: "Arial-ItalicMT", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    class func arial_blod(size:CGFloat)->UIFont{
        return UIFont(name: "Arial-BoldItalicMT", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
