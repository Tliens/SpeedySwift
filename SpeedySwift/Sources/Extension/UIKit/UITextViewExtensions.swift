//
//  UITextViewExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 9/28/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UITextView {

    /// 清空内容
    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    /// 滚动到底部
    public func scrollToBottom() {
        // swiftlint:disable next legacy_constructor
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
    }

    /// 滚动到顶部
    public func scrollToTop() {
        // swiftlint:disable next legacy_constructor
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }

    /// 自动换行到内容(文本/带属性的文本)。
    public func wrapToContent() {
        contentInset = UIEdgeInsets.zero
        scrollIndicatorInsets = UIEdgeInsets.zero
        contentOffset = CGPoint.zero
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
        sizeToFit()
    }

}
#endif
