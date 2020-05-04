//
//  UIGestureRecognizerpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 4/21/18.
//  Copyright © 2018 SpeedySwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UIGestureRecognizer {

    /// 从当前view移除手势
    func removeFromView() {
        view?.removeGestureRecognizer(self)
    }

}
#endif
