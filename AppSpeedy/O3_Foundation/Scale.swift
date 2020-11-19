//
//  UI+Scale.swift
//  WorldClock
//
//  Created by 2020 on 2020/10/20.
//

import UIKit
extension CGFloat{
    var scale:CGFloat{
        return App.scale(self)
    }
}

extension Int{
    var scale:CGFloat{
        return App.scale(CGFloat(self))
    }
}
extension Double{
    var scale:CGFloat{
        return App.scale(CGFloat(self))
    }
}
