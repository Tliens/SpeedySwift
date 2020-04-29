//
//  SpeedySwift+Hint.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//
// MARK: 提示框
import Foundation
import UIKit
typealias SS = SpeedySwift
extension SS{
    
    /// 自动消失的提示框，可以自定义文字和图片
    /// - Parameters:
    ///   - imgNamed: 图片名称
    ///   - txt: 提示内容
    ///   - view: superview
    ///   - completed: 消失或错误的回调
    static func hint(imgNamed:String,txt:String,view:UIView?,completed:((Error?)->())? = nil){
        let hint = UINib(nibName: "HintView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! HintView
        hint.image.image = UIImage(named: imgNamed)
        hint.title.text = txt
        var superView:UIView?
        if let view = view{
            superView = view
        }else{
            superView = SS.mostTopViewController?.view
        }
        guard superView != nil else{
            completed?(NSError())
            return
        }
        superView!.addSubview(hint)
        hint.layoutIfNeeded()
        let animate = SS.hintAnimation(position: superView!.center)
        hint.layer.add(animate, forKey: "hint")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animate.duration) {
            hint.removeFromSuperview()
            completed?(nil)
        }
    }
}
