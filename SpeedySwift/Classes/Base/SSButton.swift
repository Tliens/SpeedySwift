//
//  SSButton.swift
//  SpeedySwift
//
//  Created by 2020 on 2021/8/2.
//

import UIKit
/// 防止按钮连击
@objcMembers
public class SSButton: UIButton {
    /// 有点单例的意思
    public static let open: Bool = {
        SSButton.initializeMethod()
        return true
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///如果不重写这个那么不管是否继承该类，所有的UIButton都将会交换方法
    open override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        super.sendAction(action, to: target, for: event)
        
    }
}

extension SSButton {
    
    private struct AssociatedKeys {
        static var eventInterval = "eventInterval"
        static var eventUnavailable = "eventUnavailable"
        static var interactiveMoreSize = "interactiveMoreSize"
    }
    
    /// 重复点击的时间 属性设置
    @objc public var eventInterval: TimeInterval {
        get {
            if let interval = objc_getAssociatedObject(self, &AssociatedKeys.eventInterval) as? TimeInterval {
                return interval
            }
            return 0.4
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventInterval, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 按钮不可点 属性设置
    private var eventUnavailable : Bool {
        get {
            if let unavailable = objc_getAssociatedObject(self, &AssociatedKeys.eventUnavailable) as? Bool {
                return unavailable
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventUnavailable, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 区域大增加值
    @objc public var interactiveMoreSize: CGSize {
        get {
            if let size = objc_getAssociatedObject(self, &AssociatedKeys.interactiveMoreSize) as? CGSize {
                return size
            }
            return .zero
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.interactiveMoreSize, newValue as CGSize, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 新建初始化方法,在这个方法中实现在运行时方法替换
    class func initializeMethod() {
        let selector = #selector(sendAction(_:to:for:))
        let newSelector = #selector(new_sendAction(_:to:for:))
        
        let method: Method = class_getInstanceMethod(self, selector)!
        let newMethod: Method = class_getInstanceMethod(self, newSelector)!
        
        if class_addMethod(self, selector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)) {
            class_replaceMethod(self, newSelector, method_getImplementation(method), method_getTypeEncoding(method))
        } else {
            method_exchangeImplementations(method, newMethod)
        }
    }
    
    /// 交换的方法
    @objc private func new_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if eventUnavailable == false {
            eventUnavailable = true
            new_sendAction(action, to: target, for: event)
            // 延时
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + eventInterval, execute: {
                self.eventUnavailable = false
            })
        }
    }
    
    
    /// 扩大点击区域
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRect =  CGRect(x: -interactiveMoreSize.width/2, y: -interactiveMoreSize.height/2, width: bounds.size.width+interactiveMoreSize.width, height: bounds.size.height+interactiveMoreSize.height)
        if (buttonRect.equalTo(bounds)) {
            return super.point(inside: point, with: event)
        }else{
            return buttonRect.contains(point)
        }
    }
}

