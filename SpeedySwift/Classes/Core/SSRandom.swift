//
//  Random.swift
//  SpeedySwift
//
//  Created by Quinn on 2020/11/18.
//

import Foundation
public extension SS{
    static func between(left:Int,right:Int)->Int{
        return Int(arc4random()%UInt32(right))+left
    }
}
