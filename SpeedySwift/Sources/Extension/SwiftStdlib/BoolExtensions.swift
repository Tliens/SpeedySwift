//
//  BoolExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 07/12/2016.
//  Copyright © 2016 SpeedySwift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension Bool {

    /// bool值Int表述
    ///
    ///        false.int -> 0
    ///        true.int -> 1
    ///
    public var int: Int {
        return self ? 1 : 0
    }

    /// bool值 String表述
    ///
    ///        false.string -> "false"
    ///        true.string -> "true"
    ///
    public var string: String {
        return description
    }

}
