//
//  UIControlExtension.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/5/4.
//  Copyright © 2020 Quinn Von. All rights reserved.
//

import UIKit

extension UIControl.State: Hashable {
    public var hashValue: Int { return Int(rawValue) }
}
