//
//  DebugPrint.swift
//  BeerGame
//
//  Created by Quinn on 2020/11/14.
//

import Foundation
extension App{
    static func log(_ items: Any...,
                    separator: String = " ",
                    terminator: String = "\n",
                    file: String = #file,
                    line: Int = #line,
                    method: String = #function)
    {
        #if DEBUG
        //如果不怕打印结果有大括号[4, "abc", [1, 2, 3]]，可以直接一句话
        //print("\((file as NSString).lastPathComponent)[\(line)], \(method):", items)
        print("\((file as NSString).lastPathComponent)[\(line)], \(method):", terminator: separator)
        var i = 0
        let j = items.count
        for a in items {
            i += 1
            print(">>>>>> ",a, terminator:i == j ? terminator: separator)
        }
        #endif
    }
}
