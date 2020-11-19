//
//  NSObject+Name.swift
//  WorldClock
//
//  Created by 2020 on 2020/10/20.
//

import Foundation
public extension NSObject{
    class var named: String {
        let array = NSStringFromClass(self).components(separatedBy: ".")
        if let name =  array.last {
            return name
        }
        return ""
    }
    
    var named: String {
        let array = NSStringFromClass(type(of: self)).components(separatedBy: ".")
        if let name =  array.last {
            return name
        }
        return ""
    }
}
