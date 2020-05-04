//
//  CGColorpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 03/02/2017.
//  Copyright © 2017 SpeedySwift
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Properties
public extension CGColor {

    #if canImport(UIKit)
    /// 转UIColor
    var  uiColor: UIColor? {
        return UIColor(cgColor: self)
    }
    #endif

    #if canImport(Cocoa)
    /// 转NSColor
    var  nsColor: NSColor? {
        return NSColor(cgColor: self)
    }
    #endif

}
#endif
