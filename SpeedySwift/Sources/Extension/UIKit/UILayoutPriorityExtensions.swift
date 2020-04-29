//
//  UILayoutPriorityExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/19/18.
//  Copyright © 2018 SpeedySwift. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

extension UILayoutPriority: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {

    // MARK: - Initializers
    
    /// float 字面量
    ///
    ///     constraint.priority = 0.5
    ///
    /// - Parameter value: The float value of the constraint
    public init(floatLiteral value: Float) {
        self.init(rawValue: value)
    }

    /// Int loat 字面量
    ///
    ///     constraint.priority = 5
    ///
    /// - Parameter value: The integer value of the constraint
    public init(integerLiteral value: Int) {
        self.init(rawValue: Float(value))
    }
}

#endif
