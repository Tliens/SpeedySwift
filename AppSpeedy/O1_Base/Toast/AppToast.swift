//
//  UIView+Toast.swift
//  GeekCalculator
//
//  Created by Quinn on 2020/10/28.
//

import UIKit

public class ToastConfigure{
    static let shared = ToastConfigure()
    private init(){}
    
    public var backgroundColor:UIColor = .black
    public var textColor:UIColor = T.color
    
    public var style:ToastStyle{
        var style = ToastStyle()
        style.backgroundColor = ToastConfigure.shared.backgroundColor
        style.titleColor = ToastConfigure.shared.textColor
        style.messageColor = ToastConfigure.shared.textColor
        style.titleFont = UIFont.sc_semibold(size: 20)
        style.messageFont = UIFont.sc_semibold(size: 20)
        style.titleAlignment = .center
        style.messageAlignment = .center
        return style
    }
}
public extension UIView{
    func toast(message:String){
        
        self.makeToast(message, duration: 1, point: self.center, title: nil, image: nil, style: ToastConfigure.shared.style, completion: nil)
    }
    func globalToast(message:String){
        if let view = UIApplication.shared.keyWindow{
            view.toast(message: message)
        }
    }
}
public extension UIViewController{
    func toast(message:String){
        self.view.toast(message: message)
    }
    func globalToast(message:String){
        if let view = UIApplication.shared.keyWindow{
            view.toast(message: message)
        }
    }
}
/*
// basic usage
self.view.makeToast("This is a piece of toast")

// toast with a specific duration and position
self.view.makeToast("This is a piece of toast", duration: 3.0, position: .top)

// toast presented with multiple options and with a completion closure
self.view.makeToast("This is a piece of toast", duration: 2.0, point: CGPoint(x: 110.0, y: 110.0), title: "Toast Title", image: UIImage(named: "toast.png")) { didTap in
    if didTap {
        print("completion from tap")
    } else {
        print("completion without tap")
    }
}

// display toast with an activity spinner
self.view.makeToastActivity(.center)

// display any view as toast
self.view.showToast(myView)

// immediately hides all toast views in self.view
self.view.hideAllToasts()
*/
