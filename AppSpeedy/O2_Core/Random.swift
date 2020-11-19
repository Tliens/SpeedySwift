//
//  Random.swift
//  BeerGame
//
//  Created by 2020 on 2020/11/18.
//

import Foundation
class Random{
    static func between(left:Int,right:Int)->Int{
        return Int(arc4random()%UInt32(right))+left
    }
}
