//
//  SpeedySwift+Log.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//

import UIKit

extension SpeedySwift{
    public static func log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
        #if DEBUG
            guard let object = object else { return }
            print("SpeedySwift ***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
        #endif
    }
}
