//
//  T.swift
//  App1125
//
//  Created by Quinn on 2020/11/27.
//

import UIKit
enum TMode:Int{
    case day = 1
    case night = 2
}

typealias T = Theme
var ThemeMode:TMode = TMode(rawValue:UD.themeMode) ?? .day
class Theme{
    
    static func changeThemeMode(){
        if ThemeMode == .day{
            UD.themeMode = TMode.night.rawValue
        }else{
            UD.themeMode = TMode.day.rawValue
        }
    }
    static let colors = [yellow3,yellow6,yellow9,blue6,blue3,black2]
    
    
    static let color = ThemeMode == .day ? T.white1 : T.black1
    
    /// 容器圆角大小
    static let cornerRadius32 = 32.scale
    static let cornerRadius26 = 26.scale
    static let cornerRadius12 = 12.scale
    static let cornerRadius8 = 8.scale
    static let cornerRadius6 = 6.scale

    // 高度
    static let panH350 = App.isX ? 350.scale + 20.scale : 350.scale
    static let panH414 = App.isX ? 414.scale + 20.scale : 414.scale
    static let panH524 = App.isX ? 524.scale + 20.scale : 524.scale
    static let panH620 = App.isX ? 620.scale + 20.scale : 620.scale
    static let panFull = App.h

    
    // 字体
    static let font20 = UIFont.pangmen_blod(size: 20.scale)
    static let font22 = UIFont.pangmen_blod(size: 22.scale)
    static let font18 = UIFont.pangmen_blod(size: 18.scale)
    static let font25 = UIFont.pangmen_blod(size: 25.scale)
    static let font16 = UIFont.pangmen_blod(size: 16.scale)
    static let font14 = UIFont.pangmen_blod(size: 14.scale)
    static let font60 = UIFont.pangmen_blod(size: 60.scale)
    static func font(_ size:CGFloat)->UIFont{
        return UIFont.pangmen_blod(size: size.scale)
    }
    //颜色
    /// 000000
    static let black1 = UIColor.hex("#000000")
    /// 001111
    static let black2 = UIColor.hex("#001111")
    /// 333333
    static let black3 = UIColor.hex("#333333")
    /// 666666
    static let black6 = UIColor.hex("#666666")
    /// 999999
    static let black9 = UIColor.hex("#999999")
    /// F7F7F7
    static let blackF7 = UIColor.hex("#F7F7F7")
    /// ff6c0a
    static let yellow2 = UIColor.hex("#FF6C0A")
    /// FFA45B
    static let yellow3 = UIColor.hex("#FFA45B")
    /// FFDA77
    static let yellow6 = UIColor.hex("#FFDA77")
    /// FBF6F0
    static let yellow9 = UIColor.hex("#FBF6F0")
    /// 7DEFEF
    static let blue3 = UIColor.hex("#7DEFEF")
    /// AEE6E6
    static let blue6 = UIColor.hex("#AEE6E6")
    /// FFFFFF
    static let white1 = UIColor.hex("#FFFFFF")
    /// DDDDDD
    static let white2 = UIColor.hex("#DDDDDD")
    
    
    /// shadow
    static let shadowOpacity:Float = ThemeMode == .day ? 0.2 : 0.6


    static func color(day:UIColor,night:UIColor)->UIColor{
        if ThemeMode == .day{
            return day
        }else{
            return night
        }
    }
}
