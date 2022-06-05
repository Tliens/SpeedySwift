//
//  SSToast.swift
//  GeekCalculator
//
//  Created by Quinn on 2020/10/28.
//

import UIKit
import Toast_Swift
public class SSToastConfigure{
    static let shared = SSToastConfigure()
    private init(){}
    
    public var backgroundColor:UIColor = .black
    public var textColor:UIColor = .white
    
    public var style:ToastStyle{
        var style = ToastStyle()
        style.backgroundColor = SSToastConfigure.shared.backgroundColor
        style.titleColor = SSToastConfigure.shared.textColor
        style.messageColor = SSToastConfigure.shared.textColor
        style.titleFont = UIFont.sc_semibold(size: 16)
        style.messageFont = UIFont.sc_medium(size: 14)
        style.titleAlignment = .center
        style.messageAlignment = .center
        return style
    }
}
public extension UIView{
    func toast(message:String,duration: TimeInterval  = 2){
        
        self.makeToast(message, duration: duration, point: self.center, title: nil, image: nil, style: SSToastConfigure.shared.style, completion: nil)
    }
    func globalToast(message:String){
        if let view = UIApplication.shared.keyWindow{
            view.toast(message: message)
        }
    }
}
public extension UIViewController{
    func toast(message:String,duration: TimeInterval  = 2){
        self.view.toast(message: message,duration: duration)
    }
    func globalToast(message:String){
        if let view = UIApplication.shared.keyWindow{
            view.toast(message: message)
        }
    }
}
