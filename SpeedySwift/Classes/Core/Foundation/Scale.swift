//
//  UI+Scale.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
public extension CGFloat{
    var scale:CGFloat{
        return SS.scale(self)
    }
}

public extension Int{
    var scale:CGFloat{
        return SS.scale(CGFloat(self))
    }
}
public extension Double{
    var scale:CGFloat{
        return SS.scale(CGFloat(self))
    }
}
