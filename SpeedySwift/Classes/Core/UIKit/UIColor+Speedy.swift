//
//  UIColor+Speedy.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import Foundation
import UIKit
extension UIColor {
    
    /// hex 色值
    public class func hex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor{
        let tempStr = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let hexint = intFromHexString(tempStr)
        let color = UIColor(red: ((CGFloat) ((hexint & 0xFF0000) >> 16))/255, green: ((CGFloat) ((hexint & 0xFF00) >> 8))/255, blue: ((CGFloat) (hexint & 0xFF))/255, alpha: alpha)
        return color
    }

    /// UIColor -> Hex String
    public var hex: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    
    /// 左右渐变色
    public static func gradient(left:UIColor,right:UIColor,rect:CGRect)->CAGradientLayer{
        func gradientLayer(rect:CGRect)->CAGradientLayer{
            let colorLayer = CAGradientLayer()
            colorLayer.frame = rect
            colorLayer.colors = [left.cgColor,right.cgColor]
            colorLayer.startPoint = CGPoint(x: 0, y: 0.5)
            colorLayer.endPoint = CGPoint(x: 1, y: 0.5)
            return colorLayer
        }
        return gradientLayer(rect: rect)
    }
    
    /// 随机颜色
    public class func randrom() -> UIColor {
        let r = CGFloat(arc4random()%256)/255.0
        let g = CGFloat(arc4random()%256)/255.0
        let b = CGFloat(arc4random()%256)/255.0
        if #available(iOS 10.0, *) {
            let color = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1)
            return color
        } else {
            // Fallback on earlier versions
            return UIColor(red: r, green: g, blue: b, alpha: 1)
        }
        
    }
    
    /// 从Hex装换int
    private class func intFromHexString(_ hexString:String)->UInt32{
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        var result : UInt32 = 0
        scanner.scanHexInt32(&result)
        return result
    }
}
