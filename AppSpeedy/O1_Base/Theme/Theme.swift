//
//  T.swift
//  App1125
//
//  Created by Quinn on 2020/11/27.
//

import UIKit
enum TMode{
    case day
    case night
}

typealias T = Theme
class Theme{
    static let colors = [yellow3,yellow6,yellow9,blue6,blue3]
    static var mode:TMode = .day
    
    
    static let color = mode == .day ? UIColor.white : UIColor.black
    
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

    
    // 字体
    static let font20 = UIFont.pangmen_blod(size: 20.scale)
    static let font22 = UIFont.pangmen_blod(size: 22.scale)
    static let font18 = UIFont.pangmen_blod(size: 18.scale)
    static let font25 = UIFont.pangmen_blod(size: 25.scale)
    static let font16 = UIFont.pangmen_blod(size: 16.scale)
    static let font14 = UIFont.pangmen_blod(size: 14.scale)

    //颜色
    static let black3 = UIColor.hex("#333333")
    static let black6 = UIColor.hex("#666666")
    static let black9 = UIColor.hex("#999999")
    
    static let yellow2 = UIColor.hex("#ff6c0a")
    static let yellow3 = UIColor.hex("#FFA45B")
    static let yellow6 = UIColor.hex("#FFDA77")
    static let yellow9 = UIColor.hex("#FBF6F0")

    static let blue3 = UIColor.hex("#7DEFEF")
    static let blue6 = UIColor.hex("#AEE6E6")

    static let white1 = UIColor.hex("#FFFFFF")
    static let white2 = UIColor.hex("#DDDDDD")

}
