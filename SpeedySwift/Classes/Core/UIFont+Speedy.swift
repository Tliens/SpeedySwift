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
    public class func arial(size:CGFloat)->UIFont{
        return UIFont(name: "Arial-ItalicMT", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    public class func arial_blod(size:CGFloat)->UIFont{
        return UIFont(name: "Arial-BoldItalicMT", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    public class func pangmen_blod(size:CGFloat)->UIFont{
        return UIFont(name: "PangMenZhengDao-3", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    public class func DIGITAL_Regular(size:CGFloat)->UIFont{
        return UIFont(name: "Digiface", size: size) ?? UIFont.systemFont(ofSize: size)
    }

}
