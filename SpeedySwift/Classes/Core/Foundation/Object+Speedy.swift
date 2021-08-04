//
//  NSObject+Name.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import Foundation
public extension NSObject{
    class var named: String {
        let array = NSStringFromClass(self).components(separatedBy: ".")
        return array.last ?? ""
    }
    
    var named: String {
        let array = NSStringFromClass(type(of: self)).components(separatedBy: ".")
        return array.last ?? ""
    }
}
