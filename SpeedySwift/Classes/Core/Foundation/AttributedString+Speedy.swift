//
//  AttributedString+Speedy+Speedy.swift
//  SpeedySwift
//
//  Created by 2020 on 2020/12/4.
//

import Foundation
import UIKit
// MARK: - Properties
public extension NSAttributedString {
    /// 粗体
    var bolded: NSAttributedString {
        guard !string.isEmpty else { return self }
        
        let pointSize: CGFloat
        if let font = attribute(.font, at: 0, effectiveRange: nil) as? UIFont {
            pointSize = font.pointSize
        } else {
            pointSize = UIFont.systemFontSize
        }
        return applying(attributes: [.font: UIFont.boldSystemFont(ofSize: pointSize)])
    }
    
    /// 下划线
    var underlined: NSAttributedString {
        return applying(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// 斜体
    var italicized: NSAttributedString {
        guard !string.isEmpty else { return self }
        
        let pointSize: CGFloat
        if let font = attribute(.font, at: 0, effectiveRange: nil) as? UIFont {
            pointSize = font.pointSize
        } else {
            pointSize = UIFont.systemFontSize
        }
        return applying(attributes: [.font: UIFont.italicSystemFont(ofSize: pointSize)])
    }
    
    /// 删除线
    var struckthrough: NSAttributedString {
        return applying(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)])
    }
    
    /// 富文本
    var attributes: [Key: Any] {
        guard length > 0 else { return [:] }
        return attributes(at: 0, effectiveRange: nil)
    }
    
}

// MARK: - Methods

public extension NSAttributedString {
    /// 添加富文本属性
    func applying(attributes: [Key: Any]) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        
        let copy = NSMutableAttributedString(attributedString: self)
        copy.addAttributes(attributes, range: NSRange(0..<length))
        return copy
    }
    
    /// 添加字体颜色
    func colored(with color: UIColor) -> NSAttributedString {
        return applying(attributes: [.foregroundColor: color])
    }
}

// MARK: - Operators

public extension NSAttributedString {
    /// 加等
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add to.
    ///   - rhs: NSAttributedString to add.
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }
    
    /// 拼接.
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add.
    ///   - rhs: NSAttributedString to add.
    /// - Returns: New instance with added NSAttributedString.
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }
}

