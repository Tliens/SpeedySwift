//
//  Int+Speedy.swift
//  App1125
//
//  Created by 2020 on 2020/12/4.
//

import Foundation
extension Int{
    var string:String{
        return "\(self)"
    }
    
    var random:Int{
        return Int(arc4random())%self
    }
}
