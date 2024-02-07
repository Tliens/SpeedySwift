//
//  UIView+Speedy.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
/// 线的位置
public enum SSLinePosition: Int {
    case top = 0
    case bottom = 1
    case center = 2
}

/// UIView的构造和函数
extension UIView {
    
    public convenience init(backgroundColor: UIColor = UIColor.white, cornerRadius: CGFloat? = nil) {
        self.init()
        self.backgroundColor = backgroundColor
        
        if let radius = cornerRadius {
            self.ss_cornerRadius = radius
        }
    }
    
    /// 从nib初始化一个View
    public static func nib<T>(bundle: Bundle? = nil) -> T {
        return UINib(nibName: self.named, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! T
    }
    
    /// 添加阴影
    public func shadow(ofColor color: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), radius: CGFloat = 2, offset: CGSize = .zero, opacity: Float = 0.2) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    /// 添加阴影图层
    public func shadowLayer(ofColor color: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), radius: CGFloat = 2, offset: CGSize = .zero, opacity: Float = 0.2,cornerRadius:CGFloat,bounds:CGRect) {
        
        let layer = CALayer()
        layer.frame = bounds
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.white.cgColor
        self.layer.insertSublayer(layer, at: 0)
        self.layer.addSublayer(layer)
    }
    
    /// 添加细线 ply线高
    @discardableResult
    public func line(position : SSLinePosition,
                     color : UIColor,
                     height : CGFloat,
                     leftPadding : CGFloat,
                     rightPadding : CGFloat) -> UIView {
        let line = UIView.init()
        line.backgroundColor = color;
        self.addSubview(line)
        
        switch position {
        case .top:
            line.snp.makeConstraints { maker in
                maker.top.equalToSuperview()
                maker.left.equalTo(leftPadding)
                maker.right.equalTo(-rightPadding)
                maker.height.equalTo(height)
            }
        case .bottom:
            line.snp.makeConstraints { maker in
                maker.bottom.equalToSuperview().offset(-height)
                maker.left.equalTo(leftPadding)
                maker.right.equalTo(-rightPadding)
                maker.height.equalTo(height)
            }
        case .center:
            line.snp.makeConstraints { maker in
                maker.centerY.equalToSuperview()
                maker.left.equalTo(leftPadding)
                maker.right.equalTo(-rightPadding)
                maker.height.equalTo(height)
            }
        }
        return line
    }
    
    /// 添加点击手势
    @discardableResult
    public func tapGestureRecognizer(target : Any?, action : Selector?, numberOfTapsRequired: Int = 1, numberOfTouchesRequired: Int = 1) -> UITapGestureRecognizer {
        
        let tapGesture = UITapGestureRecognizer.init(target: target, action: action)
        tapGesture.numberOfTapsRequired    = numberOfTapsRequired;
        tapGesture.numberOfTouchesRequired = numberOfTouchesRequired;
        tapGesture.cancelsTouchesInView    = true;
        tapGesture.delaysTouchesBegan      = true;
        tapGesture.delaysTouchesEnded      = true;
        
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
        
        return tapGesture
    }
    /// 添加长按手势
    @discardableResult
    public func addLongPressGestureRecognizer(target : Any?, action : Selector?, pressDuration: Double = 1) -> UILongPressGestureRecognizer {
        
        let longPressGesture = UILongPressGestureRecognizer.init(target: target, action: action)
        longPressGesture.minimumPressDuration    = pressDuration;
        self.addGestureRecognizer(longPressGesture)
        self.isUserInteractionEnabled = true
        return longPressGesture
    }
    
    /// 获取view的UIViewController
    public func parentViewController()->UIViewController?{
        for view in sequence(first: self.superview, next: {$0?.superview}){
            if let responder = view?.next{
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    /// 添加顶部mask
    public func topCornerRadius(rect:CGRect,radius:CGFloat){
        cornerRadius(position: [.topLeft, .topRight], cornerRadius: radius, roundedRect:rect)
    }
    
    /// 使用贝塞尔曲线设置圆角
    public func cornerRadius(position: UIRectCorner, cornerRadius: CGFloat, roundedRect: CGRect) {
        let path = UIBezierPath(roundedRect:roundedRect, byRoundingCorners: position, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let layer = CAShapeLayer()
        layer.frame = roundedRect
        layer.path = path.cgPath
        self.layer.mask = layer
    }

}

extension UIView {
    /// 设置圆角
    public var ss_cornerRadius: CGFloat {
        set {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    /// 设置边框线颜色
    public func border(color: UIColor, width: CGFloat = 1.0) {
        self.layer.masksToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    ///将当前视图转为UIImage
    public func screenshots() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { (rendererContext) in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    /// 带有高斯模糊的截屏
    public func screenshotsdrawH() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

// MARK: - view + BlurView

public extension UIView {
    
    private struct BlurAssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }
    
    var blur: SSBlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &BlurAssociatedKeys.descriptiveName
            ) as? SSBlurView {
                return blurView
            }
            self.blur = SSBlurView(to: self)
            return self.blur
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &BlurAssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

extension CALayer {
    
    public func applySketchShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOpacity = alpha
        self.shadowOffset = CGSize(width: x, height: y)
        self.shadowRadius = blur / 2.0
        
        if spread == 0 {
            self.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            self.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
