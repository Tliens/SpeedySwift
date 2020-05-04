//
//  UISearchBarpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/23/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - Properties
public extension UISearchBar {

    /// searchbar 中的 textField
    var  textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }

    /// 去掉头部和尾部的换行空格
    var  trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

}

// MARK: - Methods
public extension UISearchBar {

    /// 清空
    func clear() {
        text = ""
    }

}
#endif
