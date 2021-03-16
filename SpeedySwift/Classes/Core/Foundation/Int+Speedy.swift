//
//  Int+Speedy.swift
//  SpeedySwift
//
//  Created by 2020 on 2020/12/4.
//

import Foundation
public extension Int{
    var string:String{
        return "\(self)"
    }
    
    var random:Int{
        return Int(arc4random())%self
    }
}
