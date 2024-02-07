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
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
        
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
// MARK: - Gradient

public extension Array where Element : UIColor {
  
  func gradient(_ transform: ((_ gradient: inout CAGradientLayer) -> CAGradientLayer)? = nil) -> CAGradientLayer {
    var gradient = CAGradientLayer()
    gradient.colors = self.map { $0.cgColor }
    
    if let transform = transform {
      gradient = transform(&gradient)
    }
    
    return gradient
  }
}
