//
//  UIBarButtonItempublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 08/12/2016.
//  Copyright © 2016 SpeedySwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UIBarButtonItem {

    /// 添加目标到UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: target.
    ///   - action: selector to run when button is tapped.
    func addTargetForAction(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }

}
#endif
