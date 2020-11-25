//
//  UILabel+Speedy.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
extension UILabel {
    
    public convenience init(text : String?, textColor : UIColor?, textFont : UIFont?, textAlignment: NSTextAlignment = .left, numberLines: Int = 1) {
        self.init()
        self.text = text
        self.textColor = textColor ?? UIColor.black
        self.font = textFont ?? UIFont.systemFont(ofSize: 17.0)
        self.textAlignment = textAlignment
        self.numberOfLines = numberLines
        self.clipsToBounds = false
    }

    /// 预计高度
    public func pre_h(maxWidth: CGFloat,maxLine:Int = 0) -> CGFloat {
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
    // 预计宽度
    public func pre_w(maxHeight: CGFloat,maxLine:Int = 0) -> CGFloat {
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

