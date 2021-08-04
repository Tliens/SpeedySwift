//
//  UILabel+Speedy.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
extension UILabel {
    
    public convenience init(text : String?,
                            textColor : UIColor?,
                            textFont : UIFont?,
                            textAlignment: NSTextAlignment = .left,
                            numberLines: Int = 1) {
        self.init()
        self.text = text
        self.textColor = textColor ?? UIColor.black
        self.font = textFont ?? UIFont.systemFont(ofSize: 17.0)
        self.textAlignment = textAlignment
        self.numberOfLines = numberLines
        self.clipsToBounds = false
    }
    /// 渐变, 对emoji友好
    public func gradient(left2right:Bool,colors:[CGColor]){
        /// 此方法对emoji友好
        layoutIfNeeded()
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        //绘制渐变层
        let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        var gradientRef: CGGradient? = nil
        let _colors = colors as CFArray
        
        gradientRef = CGGradient(
                colorsSpace: colorSpaceRef,
                colors: _colors,
                locations: nil)
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
        if let gradientRef = gradientRef {
            context?.drawLinearGradient(gradientRef, start: startPoint, end: endPoint, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        }
        //取到渐变图片
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        if let gradientImage = gradientImage {
            textColor = UIColor(patternImage: gradientImage)
        }
    }
    /// 预计高度
    public func pre_h(maxWidth: CGFloat, maxLine:Int = 0) -> CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: maxWidth,
            height: CGFloat.greatestFiniteMagnitude)
        )
        label.numberOfLines = 0
        label.backgroundColor = backgroundColor
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.text = text
        label.textAlignment = textAlignment
        label.numberOfLines = maxLine
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    /// 预计宽度
    public func pre_w(maxHeight: CGFloat, maxLine:Int = 0) -> CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: CGFloat.greatestFiniteMagnitude,
            height: maxHeight)
        )
        label.numberOfLines = 0
        label.backgroundColor = backgroundColor
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.text = text
        label.textAlignment = textAlignment
        label.numberOfLines = maxLine
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.width
    }
}

