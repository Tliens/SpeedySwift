//
//  UISliderpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 9/28/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - Methods
public extension UISlider {

    /// 设置滑动条的值，可选择动画的形式
    ///
    /// - Parameters:
    ///   - value: slider value.
    ///   - animated: set true to animate value change (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: an optional completion handler to run after value is changed (default is nil)
    func setValue(_ value: Float, animated: Bool = true, duration: TimeInterval = 1, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.setValue(value, animated: true)
            }, completion: { _ in
                completion?()
            })
        } else {
            setValue(value, animated: false)
            completion?()
        }
    }

}
#endif
