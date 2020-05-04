//
//  UISwitchpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 08/12/2016.
//  Copyright © 2016 SpeedySwift
//

#if canImport(UIKit)  && os(iOS)
import UIKit

// MARK: - Methods
public extension UISwitch {

    /// 切换UISwitch
    ///
    /// - Parameter animated: set true to animate the change (default is true)
    func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }

}
#endif
