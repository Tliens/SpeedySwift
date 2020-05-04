//
//  UIDatePickerpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 12/9/17.
//  Copyright © 2017 SpeedySwift
//

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - Properties
public extension UIDatePicker {

    /// UIDatePicker文字颜色
    var  textColor: UIColor? {
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
        get {
            return value(forKeyPath: "textColor") as? UIColor
        }
    }

}
#endif
