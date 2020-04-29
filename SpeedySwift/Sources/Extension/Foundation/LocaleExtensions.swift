//
//  LocalExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 4/19/17.
//  Copyright © 2017 SpeedySwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Locale {

    /// 语言环境的UNIX表示，通常用于规范化。
    public static var posix: Locale {
        return Locale(identifier: "en_US_POSIX")
    }

}
#endif
