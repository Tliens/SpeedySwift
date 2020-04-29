//
//  UILabelExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 9/23/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UILabel {

    /// 用文本初始化UILabel
    public convenience init(text: String?) {
        self.init()
        self.text = text
    }

    /// 文本所需高度
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }

}
#endif
