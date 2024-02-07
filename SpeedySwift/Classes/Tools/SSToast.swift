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
    func toast(message:String,duration: TimeInterval  = 2, offsetY:CGFloat = 0){
        
        self.makeToast(message, duration: duration, point: CGPoint(x: self.center.x, y: self.center.y + offsetY), title: nil, image: nil, style: SSToastConfigure.shared.style, completion: nil)
    }
    func globalToast(message:String, offsetY:CGFloat = 0){
        if let view = UIApplication.shared.keyWindow{
            view.toast(message: message, offsetY:offsetY)
        }
    }
}
public extension UIViewController{
    func toast(message:String,duration: TimeInterval  = 2, offsetY:CGFloat = 0){
        self.view.toast(message: message,duration: duration, offsetY:offsetY)
    }
    func globalToast(message:String, offsetY:CGFloat = 0){
        if let view = UIApplication.shared.keyWindow{
            view.toast(message: message, offsetY:offsetY)
        }
    }
}
