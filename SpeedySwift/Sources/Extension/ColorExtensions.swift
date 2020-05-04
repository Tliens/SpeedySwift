//
//  SpeedySwift.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//

#if canImport(UIKit)
import UIKit
/// Color
public typealias Color = UIColor
#endif

#if canImport(Cocoa)
import Cocoa
/// Color
public typealias Color = NSColor
#endif

#if !os(watchOS)
import CoreImage
#endif

#if !os(Linux)
// MARK: - Properties
public extension Color {

    /// 随机颜色
    static var random: Color {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return Color(red: red, green: green, blue: blue)!
    }

    // swiftlint:disable next large_tuple
    /// rgb组成
    ///
    ///		UIColor.red.rgbComponents.red -> 255
    ///		NSColor.green.rgbComponents.green -> 255
    ///		UIColor.blue.rgbComponents.blue -> 255
    ///
    var rgbComponents: (red: Int, green: Int, blue: Int) {
        var components: [CGFloat] {
            let comps = cgColor.components!
            if comps.count == 4 { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return (red: Int(red * 255.0), green: Int(green * 255.0), blue: Int(blue * 255.0))
    }

    // swiftlint:disable next large_tuple
    /// rgb组成
    ///
    ///		UIColor.red.rgbComponents.red -> 1.0
    ///		NSColor.green.rgbComponents.green -> 1.0
    ///		UIColor.blue.rgbComponents.blue -> 1.0
    ///
    var cgFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var components: [CGFloat] {
            let comps = cgColor.components!
            if comps.count == 4 { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return (red: red, green: green, blue: blue)
    }

    // swiftlint:disable next large_tuple
    /// HSBA组成
    var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    /// hexString 6位
    var hexString: String {
        let components: [Int] = {
            let comps = cgColor.components!
            let components = comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }

    /// hexString 3位
    var shortHexString: String? {
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return nil }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }

    /// hexString 3位 或6 位
    var shortHexOrHexString: String {
        let components: [Int] = {
            let comps = cgColor.components!
            let components = comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
            return components.map { Int($0 * 255.0) }
        }()
        let hexString = String(format: "#%02X%02X%02X", components[0], components[1], components[2])
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return hexString }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }

    /// alpha值
    var alpha: CGFloat {
        return cgColor.alpha
    }

    #if !os(watchOS)
    /// SwifterSwift: CoreImage.CIColor (read-only)
    var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)
    }
    #endif

    /// UInt组成
    var uInt: UInt {
        let comps: [CGFloat] = {
            let comps = cgColor.components!
            return comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
        }()

        var colorAsUInt32: UInt32 = 0
        colorAsUInt32 += UInt32(comps[0] * 255.0) << 16
        colorAsUInt32 += UInt32(comps[1] * 255.0) << 8
        colorAsUInt32 += UInt32(comps[2] * 255.0)

        return UInt(colorAsUInt32)
    }

    /// 互补色
    var complementary: Color? {
        let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
        let convertColorToRGBSpace: ((_ color: Color) -> Color?) = { color -> Color? in
            if self.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
                let oldComponents = self.cgColor.components
                let components: [CGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
                let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
                let colorOut = Color(cgColor: colorRef!)
                return colorOut
            } else {
                return self
            }
        }

        let color = convertColorToRGBSpace(self)
        guard let componentColors = color?.cgColor.components else { return nil }

        let red: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[0]*255), 2.0))/255
        let green: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[1]*255), 2.0))/255
        let blue: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[2]*255), 2.0))/255

        return Color(red: red, green: green, blue: blue, alpha: 1.0)
    }

}

// MARK: - Methods
public extension Color {

    /// 两个颜色 blend
    ///
    /// - Parameters:
    ///   - color1: first color to blend
    ///   - intensity1: intensity of first color (default is 0.5)
    ///   - color2: second color to blend
    ///   - intensity2: intensity of second color (default is 0.5)
    /// - Returns: Color created by blending first and seond colors.
    static func blend(_ color1: Color, intensity1: CGFloat = 0.5, with color2: Color, intensity2: CGFloat = 0.5) -> Color {
        // http://stackoverflow.com/questions/27342715/blend-uicolors-in-swift

        let total = intensity1 + intensity2
        let level1 = intensity1/total
        let level2 = intensity2/total

        guard level1 > 0 else { return color2 }
        guard level2 > 0 else { return color1 }

        let components1: [CGFloat] = {
            let comps = color1.cgColor.components!
            return comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
        }()

        let components2: [CGFloat] = {
            let comps = color2.cgColor.components!
            return comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
        }()

        let red1 = components1[0]
        let red2 = components2[0]

        let green1 = components1[1]
        let green2 = components2[1]

        let blue1 = components1[2]
        let blue2 = components2[2]

        let alpha1 = color1.cgColor.alpha
        let alpha2 = color2.cgColor.alpha

        let red = level1*red1 + level2*red2
        let green = level1*green1 + level2*green2
        let blue = level1*blue1 + level2*blue2
        let alpha = level1*alpha1 + level2*alpha2

        return Color(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// 颜色提亮
    ///
    ///     let color = Color(red: r, green: g, blue: b, alpha: a)
    ///     let lighterColor: Color = color.lighten(by: 0.2)
    ///
    /// - Parameter percentage: Percentage by which to lighten the color
    /// - Returns: A lightened color
    func lighten(by percentage: CGFloat = 0.2) -> Color {
        // https://stackoverflow.com/questions/38435308/swift-get-lighter-and-darker-color-variations-for-a-given-uicolor
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return Color(red: min(red + percentage, 1.0),
                     green: min(green + percentage, 1.0),
                     blue: min(blue + percentage, 1.0),
                     alpha: alpha)
    }

    /// 颜色变黑
    ///
    ///     let color = Color(red: r, green: g, blue: b, alpha: a)
    ///     let darkerColor: Color = color.darken(by: 0.2)
    ///
    /// - Parameter percentage: Percentage by which to darken the color
    /// - Returns: A darkened color
    func darken(by percentage: CGFloat = 0.2) -> Color {
        // https://stackoverflow.com/questions/38435308/swift-get-lighter-and-darker-color-variations-for-a-given-uicolor
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return Color(red: max(red - percentage, 0),
                     green: max(green - percentage, 0),
                     blue: max(blue - percentage, 0),
                     alpha: alpha)
    }

}

// MARK: - Initializers
public extension Color {

    /// 创建颜色从RGB值与可选的透明度
    ///
    /// - Parameters:
    ///   - red: red component.
    ///   - green: green component.
    ///   - blue: blue component.
    ///   - transparency: optional transparency value (default is 1).
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }

    /// init：从十六进制值与可选的透明度创建颜色.
    ///
    /// - Parameters:
    ///   - hex: hex Int (example: 0xDECEB5).
    ///   - transparency: optional transparency value (default is 1).
    convenience init?(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }

    /// init：从十六进制字符串与可选的透明度创建
    ///
    /// - Parameters:
    ///   - hexString: hexadecimal string (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
    ///   - transparency: optional transparency value (default is 1).
    convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }

    /// 从一种颜色的互补中创造出一种颜色
    ///
    /// - Parameter color: color of which opposite color is desired.
    convenience init?(complementaryFor color: Color) {
        let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
        let convertColorToRGBSpace: ((_ color: Color) -> Color?) = { color -> Color? in
            if color.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
                let oldComponents = color.cgColor.components
                let components: [CGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
                let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
                let colorOut = Color(cgColor: colorRef!)
                return colorOut
            } else {
                return color
            }
        }

        let color = convertColorToRGBSpace(color)
        guard let componentColors = color?.cgColor.components else { return nil }

        let red: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[0]*255), 2.0))/255
        let green: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[1]*255), 2.0))/255
        let blue: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[2]*255), 2.0))/255
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

}

// swiftlint:disable next type_body_length
// MARK: - Social
public extension Color {

    /// 大众社交媒体平台的品牌身份色彩。
    struct Social {
        // https://www.lockedowndesign.com/social-media-colors/

        /// red: 59, green: 89, blue: 152
        static let facebook = Color(red: 59, green: 89, blue: 152)!

        /// red: 0, green: 182, blue: 241
        static let twitter = Color(red: 0, green: 182, blue: 241)!

        /// red: 223, green: 74, blue: 50
        static let googlePlus = Color(red: 223, green: 74, blue: 50)!

        /// red: 0, green: 123, blue: 182
        static let linkedIn = Color(red: 0, green: 123, blue: 182)!

        /// red: 69, green: 187, blue: 255
        static let vimeo = Color(red: 69, green: 187, blue: 255)!

        /// red: 179, green: 18, blue: 23
        static let youtube = Color(red: 179, green: 18, blue: 23)!

        /// red: 195, green: 42, blue: 163
        static let instagram = Color(red: 195, green: 42, blue: 163)!

        /// red: 203, green: 32, blue: 39
        static let pinterest = Color(red: 203, green: 32, blue: 39)!

        /// red: 244, green: 0, blue: 131
        static let flickr = Color(red: 244, green: 0, blue: 131)!

        /// red: 67, green: 2, blue: 151
        static let yahoo = Color(red: 67, green: 2, blue: 151)!

        /// red: 67, green: 2, blue: 151
        static let soundCloud = Color(red: 67, green: 2, blue: 151)!

        /// red: 44, green: 71, blue: 98
        static let tumblr = Color(red: 44, green: 71, blue: 98)!

        /// red: 252, green: 69, blue: 117
        static let foursquare = Color(red: 252, green: 69, blue: 117)!

        /// red: 255, green: 176, blue: 0
        static let swarm = Color(red: 255, green: 176, blue: 0)!

        /// red: 234, green: 76, blue: 137
        static let dribbble = Color(red: 234, green: 76, blue: 137)!

        /// red: 255, green: 87, blue: 0
        static let reddit = Color(red: 255, green: 87, blue: 0)!

        /// red: 74, green: 93, blue: 78
        static let devianArt = Color(red: 74, green: 93, blue: 78)!

        /// red: 238, green: 64, blue: 86
        static let pocket = Color(red: 238, green: 64, blue: 86)!

        /// red: 170, green: 34, blue: 182
        static let quora = Color(red: 170, green: 34, blue: 182)!

        /// red: 247, green: 146, blue: 30
        static let slideShare = Color(red: 247, green: 146, blue: 30)!

        /// red: 0, green: 153, blue: 229
        static let px500 = Color(red: 0, green: 153, blue: 229)!

        /// red: 223, green: 109, blue: 70
        static let listly = Color(red: 223, green: 109, blue: 70)!

        /// red: 0, green: 180, blue: 137
        static let vine = Color(red: 0, green: 180, blue: 137)!

        /// red: 0, green: 175, blue: 240
        static let skype = Color(red: 0, green: 175, blue: 240)!

        /// red: 235, green: 73, blue: 36
        static let stumbleUpon = Color(red: 235, green: 73, blue: 36)!

        /// red: 255, green: 252, blue: 0
        static let snapchat = Color(red: 255, green: 252, blue: 0)!

        /// red: 37, green: 211, blue: 102
        static let whatsApp = Color(red: 37, green: 211, blue: 102)!
    }

}

// MARK: - Material colors
public extension Color {

    /// Google Material设计颜色调色板。
    struct Material {
        // https://material.google.com/style/color.html

        /// SwifterSwift: color red500
        static let red					= red500

        /// SwifterSwift: hex #FFEBEE
        static let red50					= Color(hex: 0xFFEBEE)!

        /// SwifterSwift: hex #FFCDD2
        static let red100				= Color(hex: 0xFFCDD2)!

        /// SwifterSwift: hex #EF9A9A
        static let red200				= Color(hex: 0xEF9A9A)!

        /// SwifterSwift: hex #E57373
        static let red300				= Color(hex: 0xE57373)!

        /// SwifterSwift: hex #EF5350
        static let red400				= Color(hex: 0xEF5350)!

        /// SwifterSwift: hex #F44336
        static let red500				= Color(hex: 0xF44336)!

        /// SwifterSwift: hex #E53935
        static let red600				= Color(hex: 0xE53935)!

        /// SwifterSwift: hex #D32F2F
        static let red700				= Color(hex: 0xD32F2F)!

        /// SwifterSwift: hex #C62828
        static let red800				= Color(hex: 0xC62828)!

        /// SwifterSwift: hex #B71C1C
        static let red900				= Color(hex: 0xB71C1C)!

        /// SwifterSwift: hex #FF8A80
        static let redA100				= Color(hex: 0xFF8A80)!

        /// SwifterSwift: hex #FF5252
        static let redA200				= Color(hex: 0xFF5252)!

        /// SwifterSwift: hex #FF1744
        static let redA400				= Color(hex: 0xFF1744)!

        /// SwifterSwift: hex #D50000
        static let redA700				= Color(hex: 0xD50000)!

        /// SwifterSwift: color pink500
        static let pink					= pink500

        /// SwifterSwift: hex #FCE4EC
        static let pink50				= Color(hex: 0xFCE4EC)!

        /// SwifterSwift: hex #F8BBD0
        static let pink100				= Color(hex: 0xF8BBD0)!

        /// SwifterSwift: hex #F48FB1
        static let pink200				= Color(hex: 0xF48FB1)!

        /// SwifterSwift: hex #F06292
        static let pink300				= Color(hex: 0xF06292)!

        /// SwifterSwift: hex #EC407A
        static let pink400				= Color(hex: 0xEC407A)!

        /// SwifterSwift: hex #E91E63
        static let pink500				= Color(hex: 0xE91E63)!

        /// SwifterSwift: hex #D81B60
        static let pink600				= Color(hex: 0xD81B60)!

        /// SwifterSwift: hex #C2185B
        static let pink700				= Color(hex: 0xC2185B)!

        /// SwifterSwift: hex #AD1457
        static let pink800				= Color(hex: 0xAD1457)!

        /// SwifterSwift: hex #880E4F
        static let pink900				= Color(hex: 0x880E4F)!

        /// SwifterSwift: hex #FF80AB
        static let pinkA100				= Color(hex: 0xFF80AB)!

        /// SwifterSwift: hex #FF4081
        static let pinkA200				= Color(hex: 0xFF4081)!

        /// SwifterSwift: hex #F50057
        static let pinkA400				= Color(hex: 0xF50057)!

        /// SwifterSwift: hex #C51162
        static let pinkA700				= Color(hex: 0xC51162)!

        /// SwifterSwift: color purple500
        static let purple				= purple500

        /// SwifterSwift: hex #F3E5F5
        static let purple50				= Color(hex: 0xF3E5F5)!

        /// SwifterSwift: hex #E1BEE7
        static let purple100				= Color(hex: 0xE1BEE7)!

        /// SwifterSwift: hex #CE93D8
        static let purple200				= Color(hex: 0xCE93D8)!

        /// SwifterSwift: hex #BA68C8
        static let purple300				= Color(hex: 0xBA68C8)!

        /// SwifterSwift: hex #AB47BC
        static let purple400				= Color(hex: 0xAB47BC)!

        /// SwifterSwift: hex #9C27B0
        static let purple500				= Color(hex: 0x9C27B0)!

        /// SwifterSwift: hex #8E24AA
        static let purple600				= Color(hex: 0x8E24AA)!

        /// SwifterSwift: hex #7B1FA2
        static let purple700				= Color(hex: 0x7B1FA2)!

        /// SwifterSwift: hex #6A1B9A
        static let purple800				= Color(hex: 0x6A1B9A)!

        /// SwifterSwift: hex #4A148C
        static let purple900				= Color(hex: 0x4A148C)!

        /// SwifterSwift: hex #EA80FC
        static let purpleA100			= Color(hex: 0xEA80FC)!

        /// SwifterSwift: hex #E040FB
        static let purpleA200			= Color(hex: 0xE040FB)!

        /// SwifterSwift: hex #D500F9
        static let purpleA400			= Color(hex: 0xD500F9)!

        /// SwifterSwift: hex #AA00FF
        static let purpleA700			= Color(hex: 0xAA00FF)!

        /// SwifterSwift: color deepPurple500
        static let deepPurple			= deepPurple500

        /// SwifterSwift: hex #EDE7F6
        static let deepPurple50			= Color(hex: 0xEDE7F6)!

        /// SwifterSwift: hex #D1C4E9
        static let deepPurple100			= Color(hex: 0xD1C4E9)!

        /// SwifterSwift: hex #B39DDB
        static let deepPurple200			= Color(hex: 0xB39DDB)!

        /// SwifterSwift: hex #9575CD
        static let deepPurple300			= Color(hex: 0x9575CD)!

        /// SwifterSwift: hex #7E57C2
        static let deepPurple400			= Color(hex: 0x7E57C2)!

        /// SwifterSwift: hex #673AB7
        static let deepPurple500			= Color(hex: 0x673AB7)!

        /// SwifterSwift: hex #5E35B1
        static let deepPurple600			= Color(hex: 0x5E35B1)!

        /// SwifterSwift: hex #512DA8
        static let deepPurple700			= Color(hex: 0x512DA8)!

        /// SwifterSwift: hex #4527A0
        static let deepPurple800			= Color(hex: 0x4527A0)!

        /// SwifterSwift: hex #311B92
        static let deepPurple900			= Color(hex: 0x311B92)!

        /// SwifterSwift: hex #B388FF
        static let deepPurpleA100		= Color(hex: 0xB388FF)!

        /// SwifterSwift: hex #7C4DFF
        static let deepPurpleA200		= Color(hex: 0x7C4DFF)!

        /// SwifterSwift: hex #651FFF
        static let deepPurpleA400		= Color(hex: 0x651FFF)!

        /// SwifterSwift: hex #6200EA
        static let deepPurpleA700		= Color(hex: 0x6200EA)!

        /// SwifterSwift: color indigo500
        static let indigo				= indigo500

        /// SwifterSwift: hex #E8EAF6
        static let indigo50				= Color(hex: 0xE8EAF6)!

        /// SwifterSwift: hex #C5CAE9
        static let indigo100				= Color(hex: 0xC5CAE9)!

        /// SwifterSwift: hex #9FA8DA
        static let indigo200				= Color(hex: 0x9FA8DA)!

        /// SwifterSwift: hex #7986CB
        static let indigo300				= Color(hex: 0x7986CB)!

        /// SwifterSwift: hex #5C6BC0
        static let indigo400				= Color(hex: 0x5C6BC0)!

        /// SwifterSwift: hex #3F51B5
        static let indigo500				= Color(hex: 0x3F51B5)!

        /// SwifterSwift: hex #3949AB
        static let indigo600				= Color(hex: 0x3949AB)!

        /// SwifterSwift: hex #303F9F
        static let indigo700				= Color(hex: 0x303F9F)!

        /// SwifterSwift: hex #283593
        static let indigo800				= Color(hex: 0x283593)!

        /// SwifterSwift: hex #1A237E
        static let indigo900				= Color(hex: 0x1A237E)!

        /// SwifterSwift: hex #8C9EFF
        static let indigoA100			= Color(hex: 0x8C9EFF)!

        /// SwifterSwift: hex #536DFE
        static let indigoA200			= Color(hex: 0x536DFE)!

        /// SwifterSwift: hex #3D5AFE
        static let indigoA400			= Color(hex: 0x3D5AFE)!

        /// SwifterSwift: hex #304FFE
        static let indigoA700			= Color(hex: 0x304FFE)!

        /// SwifterSwift: color blue500
        static let blue					= blue500

        /// SwifterSwift: hex #E3F2FD
        static let blue50				= Color(hex: 0xE3F2FD)!

        /// SwifterSwift: hex #BBDEFB
        static let blue100				= Color(hex: 0xBBDEFB)!

        /// SwifterSwift: hex #90CAF9
        static let blue200				= Color(hex: 0x90CAF9)!

        /// SwifterSwift: hex #64B5F6
        static let blue300				= Color(hex: 0x64B5F6)!

        /// SwifterSwift: hex #42A5F5
        static let blue400				= Color(hex: 0x42A5F5)!

        /// SwifterSwift: hex #2196F3
        static let blue500				= Color(hex: 0x2196F3)!

        /// SwifterSwift: hex #1E88E5
        static let blue600				= Color(hex: 0x1E88E5)!

        /// SwifterSwift: hex #1976D2
        static let blue700				= Color(hex: 0x1976D2)!

        /// SwifterSwift: hex #1565C0
        static let blue800				= Color(hex: 0x1565C0)!

        /// SwifterSwift: hex #0D47A1
        static let blue900				= Color(hex: 0x0D47A1)!

        /// SwifterSwift: hex #82B1FF
        static let blueA100				= Color(hex: 0x82B1FF)!

        /// SwifterSwift: hex #448AFF
        static let blueA200				= Color(hex: 0x448AFF)!

        /// SwifterSwift: hex #2979FF
        static let blueA400				= Color(hex: 0x2979FF)!

        /// SwifterSwift: hex #2962FF
        static let blueA700				= Color(hex: 0x2962FF)!

        /// SwifterSwift: color lightBlue500
        static let lightBlue				= lightBlue500

        /// SwifterSwift: hex #E1F5FE
        static let lightBlue50			= Color(hex: 0xE1F5FE)!

        /// SwifterSwift: hex #B3E5FC
        static let lightBlue100			= Color(hex: 0xB3E5FC)!

        /// SwifterSwift: hex #81D4FA
        static let lightBlue200			= Color(hex: 0x81D4FA)!

        /// SwifterSwift: hex #4FC3F7
        static let lightBlue300			= Color(hex: 0x4FC3F7)!

        /// SwifterSwift: hex #29B6F6
        static let lightBlue400			= Color(hex: 0x29B6F6)!

        /// SwifterSwift: hex #03A9F4
        static let lightBlue500			= Color(hex: 0x03A9F4)!

        /// SwifterSwift: hex #039BE5
        static let lightBlue600			= Color(hex: 0x039BE5)!

        /// SwifterSwift: hex #0288D1
        static let lightBlue700			= Color(hex: 0x0288D1)!

        /// SwifterSwift: hex #0277BD
        static let lightBlue800			= Color(hex: 0x0277BD)!

        /// SwifterSwift: hex #01579B
        static let lightBlue900			= Color(hex: 0x01579B)!

        /// SwifterSwift: hex #80D8FF
        static let lightBlueA100			= Color(hex: 0x80D8FF)!

        /// SwifterSwift: hex #40C4FF
        static let lightBlueA200			= Color(hex: 0x40C4FF)!

        /// SwifterSwift: hex #00B0FF
        static let lightBlueA400			= Color(hex: 0x00B0FF)!

        /// SwifterSwift: hex #0091EA
        static let lightBlueA700			= Color(hex: 0x0091EA)!

        /// SwifterSwift: color cyan500
        static let cyan					= cyan500

        /// SwifterSwift: hex #E0F7FA
        static let cyan50				= Color(hex: 0xE0F7FA)!

        /// SwifterSwift: hex #B2EBF2
        static let cyan100				= Color(hex: 0xB2EBF2)!

        /// SwifterSwift: hex #80DEEA
        static let cyan200				= Color(hex: 0x80DEEA)!

        /// SwifterSwift: hex #4DD0E1
        static let cyan300				= Color(hex: 0x4DD0E1)!

        /// SwifterSwift: hex #26C6DA
        static let cyan400				= Color(hex: 0x26C6DA)!

        /// SwifterSwift: hex #00BCD4
        static let cyan500				= Color(hex: 0x00BCD4)!

        /// SwifterSwift: hex #00ACC1
        static let cyan600				= Color(hex: 0x00ACC1)!

        /// SwifterSwift: hex #0097A7
        static let cyan700				= Color(hex: 0x0097A7)!

        /// SwifterSwift: hex #00838F
        static let cyan800				= Color(hex: 0x00838F)!

        /// SwifterSwift: hex #006064
        static let cyan900				= Color(hex: 0x006064)!

        /// SwifterSwift: hex #84FFFF
        static let cyanA100				= Color(hex: 0x84FFFF)!

        /// SwifterSwift: hex #18FFFF
        static let cyanA200				= Color(hex: 0x18FFFF)!

        /// SwifterSwift: hex #00E5FF
        static let cyanA400				= Color(hex: 0x00E5FF)!

        /// SwifterSwift: hex #00B8D4
        static let cyanA700				= Color(hex: 0x00B8D4)!

        /// SwifterSwift: color teal500
        static let teal					= teal500

        /// SwifterSwift: hex #E0F2F1
        static let teal50				= Color(hex: 0xE0F2F1)!

        /// SwifterSwift: hex #B2DFDB
        static let teal100				= Color(hex: 0xB2DFDB)!

        /// SwifterSwift: hex #80CBC4
        static let teal200				= Color(hex: 0x80CBC4)!

        /// SwifterSwift: hex #4DB6AC
        static let teal300				= Color(hex: 0x4DB6AC)!

        /// SwifterSwift: hex #26A69A
        static let teal400				= Color(hex: 0x26A69A)!

        /// SwifterSwift: hex #009688
        static let teal500				= Color(hex: 0x009688)!

        /// SwifterSwift: hex #00897B
        static let teal600				= Color(hex: 0x00897B)!

        /// SwifterSwift: hex #00796B
        static let teal700				= Color(hex: 0x00796B)!

        /// SwifterSwift: hex #00695C
        static let teal800				= Color(hex: 0x00695C)!

        /// SwifterSwift: hex #004D40
        static let teal900				= Color(hex: 0x004D40)!

        /// SwifterSwift: hex #A7FFEB
        static let tealA100				= Color(hex: 0xA7FFEB)!

        /// SwifterSwift: hex #64FFDA
        static let tealA200				= Color(hex: 0x64FFDA)!

        /// SwifterSwift: hex #1DE9B6
        static let tealA400				= Color(hex: 0x1DE9B6)!

        /// SwifterSwift: hex #00BFA5
        static let tealA700				= Color(hex: 0x00BFA5)!

        /// SwifterSwift: color green500
        static let green					= green500

        /// SwifterSwift: hex #E8F5E9
        static let green50				= Color(hex: 0xE8F5E9)!

        /// SwifterSwift: hex #C8E6C9
        static let green100				= Color(hex: 0xC8E6C9)!

        /// SwifterSwift: hex #A5D6A7
        static let green200				= Color(hex: 0xA5D6A7)!

        /// SwifterSwift: hex #81C784
        static let green300				= Color(hex: 0x81C784)!

        /// SwifterSwift: hex #66BB6A
        static let green400				= Color(hex: 0x66BB6A)!

        /// SwifterSwift: hex #4CAF50
        static let green500				= Color(hex: 0x4CAF50)!

        /// SwifterSwift: hex #43A047
        static let green600				= Color(hex: 0x43A047)!

        /// SwifterSwift: hex #388E3C
        static let green700				= Color(hex: 0x388E3C)!

        /// SwifterSwift: hex #2E7D32
        static let green800				= Color(hex: 0x2E7D32)!

        /// SwifterSwift: hex #1B5E20
        static let green900				= Color(hex: 0x1B5E20)!

        /// SwifterSwift: hex #B9F6CA
        static let greenA100				= Color(hex: 0xB9F6CA)!

        /// SwifterSwift: hex #69F0AE
        static let greenA200				= Color(hex: 0x69F0AE)!

        /// SwifterSwift: hex #00E676
        static let greenA400				= Color(hex: 0x00E676)!

        /// SwifterSwift: hex #00C853
        static let greenA700				= Color(hex: 0x00C853)!

        /// SwifterSwift: color lightGreen500
        static let lightGreen			= lightGreen500

        /// SwifterSwift: hex #F1F8E9
        static let lightGreen50			= Color(hex: 0xF1F8E9)!

        /// SwifterSwift: hex #DCEDC8
        static let lightGreen100			= Color(hex: 0xDCEDC8)!

        /// SwifterSwift: hex #C5E1A5
        static let lightGreen200			= Color(hex: 0xC5E1A5)!

        /// SwifterSwift: hex #AED581
        static let lightGreen300			= Color(hex: 0xAED581)!

        /// SwifterSwift: hex #9CCC65
        static let lightGreen400			= Color(hex: 0x9CCC65)!

        /// SwifterSwift: hex #8BC34A
        static let lightGreen500			= Color(hex: 0x8BC34A)!

        /// SwifterSwift: hex #7CB342
        static let lightGreen600			= Color(hex: 0x7CB342)!

        /// SwifterSwift: hex #689F38
        static let lightGreen700			= Color(hex: 0x689F38)!

        /// SwifterSwift: hex #558B2F
        static let lightGreen800			= Color(hex: 0x558B2F)!

        /// SwifterSwift: hex #33691E
        static let lightGreen900			= Color(hex: 0x33691E)!

        /// SwifterSwift: hex #CCFF90
        static let lightGreenA100		= Color(hex: 0xCCFF90)!

        /// SwifterSwift: hex #B2FF59
        static let lightGreenA200		= Color(hex: 0xB2FF59)!

        /// SwifterSwift: hex #76FF03
        static let lightGreenA400		= Color(hex: 0x76FF03)!

        /// SwifterSwift: hex #64DD17
        static let lightGreenA700		= Color(hex: 0x64DD17)!

        /// SwifterSwift: color lime500
        static let lime					= lime500

        /// SwifterSwift: hex #F9FBE7
        static let lime50				= Color(hex: 0xF9FBE7)!

        /// SwifterSwift: hex #F0F4C3
        static let lime100				= Color(hex: 0xF0F4C3)!

        /// SwifterSwift: hex #E6EE9C
        static let lime200				= Color(hex: 0xE6EE9C)!

        /// SwifterSwift: hex #DCE775
        static let lime300				= Color(hex: 0xDCE775)!

        /// SwifterSwift: hex #D4E157
        static let lime400				= Color(hex: 0xD4E157)!

        /// SwifterSwift: hex #CDDC39
        static let lime500				= Color(hex: 0xCDDC39)!

        /// SwifterSwift: hex #C0CA33
        static let lime600				= Color(hex: 0xC0CA33)!

        /// SwifterSwift: hex #AFB42B
        static let lime700				= Color(hex: 0xAFB42B)!

        /// SwifterSwift: hex #9E9D24
        static let lime800				= Color(hex: 0x9E9D24)!

        /// SwifterSwift: hex #827717
        static let lime900				= Color(hex: 0x827717)!

        /// SwifterSwift: hex #F4FF81
        static let limeA100				= Color(hex: 0xF4FF81)!

        /// SwifterSwift: hex #EEFF41
        static let limeA200				= Color(hex: 0xEEFF41)!

        /// SwifterSwift: hex #C6FF00
        static let limeA400				= Color(hex: 0xC6FF00)!

        /// SwifterSwift: hex #AEEA00
        static let limeA700				= Color(hex: 0xAEEA00)!

        /// SwifterSwift: color yellow500
        static let yellow				= yellow500

        /// SwifterSwift: hex #FFFDE7
        static let yellow50				= Color(hex: 0xFFFDE7)!

        /// SwifterSwift: hex #FFF9C4
        static let yellow100				= Color(hex: 0xFFF9C4)!

        /// SwifterSwift: hex #FFF59D
        static let yellow200				= Color(hex: 0xFFF59D)!

        /// SwifterSwift: hex #FFF176
        static let yellow300				= Color(hex: 0xFFF176)!

        /// SwifterSwift: hex #FFEE58
        static let yellow400				= Color(hex: 0xFFEE58)!

        /// SwifterSwift: hex #FFEB3B
        static let yellow500				= Color(hex: 0xFFEB3B)!

        /// SwifterSwift: hex #FDD835
        static let yellow600				= Color(hex: 0xFDD835)!

        /// SwifterSwift: hex #FBC02D
        static let yellow700				= Color(hex: 0xFBC02D)!

        /// SwifterSwift: hex #F9A825
        static let yellow800				= Color(hex: 0xF9A825)!

        /// SwifterSwift: hex #F57F17
        static let yellow900				= Color(hex: 0xF57F17)!

        /// SwifterSwift: hex #FFFF8D
        static let yellowA100			= Color(hex: 0xFFFF8D)!

        /// SwifterSwift: hex #FFFF00
        static let yellowA200			= Color(hex: 0xFFFF00)!

        /// SwifterSwift: hex #FFEA00
        static let yellowA400			= Color(hex: 0xFFEA00)!

        /// SwifterSwift: hex #FFD600
        static let yellowA700			= Color(hex: 0xFFD600)!

        /// SwifterSwift: color amber500
        static let amber					= amber500

        /// SwifterSwift: hex #FFF8E1
        static let amber50				= Color(hex: 0xFFF8E1)!

        /// SwifterSwift: hex #FFECB3
        static let amber100				= Color(hex: 0xFFECB3)!

        /// SwifterSwift: hex #FFE082
        static let amber200				= Color(hex: 0xFFE082)!

        /// SwifterSwift: hex #FFD54F
        static let amber300				= Color(hex: 0xFFD54F)!

        /// SwifterSwift: hex #FFCA28
        static let amber400				= Color(hex: 0xFFCA28)!

        /// SwifterSwift: hex #FFC107
        static let amber500				= Color(hex: 0xFFC107)!

        /// SwifterSwift: hex #FFB300
        static let amber600				= Color(hex: 0xFFB300)!

        /// SwifterSwift: hex #FFA000
        static let amber700				= Color(hex: 0xFFA000)!

        /// SwifterSwift: hex #FF8F00
        static let amber800				= Color(hex: 0xFF8F00)!

        /// SwifterSwift: hex #FF6F00
        static let amber900				= Color(hex: 0xFF6F00)!

        /// SwifterSwift: hex #FFE57F
        static let amberA100				= Color(hex: 0xFFE57F)!

        /// SwifterSwift: hex #FFD740
        static let amberA200				= Color(hex: 0xFFD740)!

        /// SwifterSwift: hex #FFC400
        static let amberA400				= Color(hex: 0xFFC400)!

        /// SwifterSwift: hex #FFAB00
        static let amberA700				= Color(hex: 0xFFAB00)!

        /// SwifterSwift: color orange500
        static let orange				= orange500

        /// SwifterSwift: hex #FFF3E0
        static let orange50				= Color(hex: 0xFFF3E0)!

        /// SwifterSwift: hex #FFE0B2
        static let orange100				= Color(hex: 0xFFE0B2)!

        /// SwifterSwift: hex #FFCC80
        static let orange200				= Color(hex: 0xFFCC80)!

        /// SwifterSwift: hex #FFB74D
        static let orange300				= Color(hex: 0xFFB74D)!

        /// SwifterSwift: hex #FFA726
        static let orange400				= Color(hex: 0xFFA726)!

        /// SwifterSwift: hex #FF9800
        static let orange500				= Color(hex: 0xFF9800)!

        /// SwifterSwift: hex #FB8C00
        static let orange600				= Color(hex: 0xFB8C00)!

        /// SwifterSwift: hex #F57C00
        static let orange700				= Color(hex: 0xF57C00)!

        /// SwifterSwift: hex #EF6C00
        static let orange800				= Color(hex: 0xEF6C00)!

        /// SwifterSwift: hex #E65100
        static let orange900				= Color(hex: 0xE65100)!

        /// SwifterSwift: hex #FFD180
        static let orangeA100			= Color(hex: 0xFFD180)!

        /// SwifterSwift: hex #FFAB40
        static let orangeA200			= Color(hex: 0xFFAB40)!

        /// SwifterSwift: hex #FF9100
        static let orangeA400			= Color(hex: 0xFF9100)!

        /// SwifterSwift: hex #FF6D00
        static let orangeA700			= Color(hex: 0xFF6D00)!

        /// SwifterSwift: color deepOrange500
        static let deepOrange			= deepOrange500

        /// SwifterSwift: hex #FBE9E7
        static let deepOrange50			= Color(hex: 0xFBE9E7)!

        /// SwifterSwift: hex #FFCCBC
        static let deepOrange100			= Color(hex: 0xFFCCBC)!

        /// SwifterSwift: hex #FFAB91
        static let deepOrange200			= Color(hex: 0xFFAB91)!

        /// SwifterSwift: hex #FF8A65
        static let deepOrange300			= Color(hex: 0xFF8A65)!

        /// SwifterSwift: hex #FF7043
        static let deepOrange400			= Color(hex: 0xFF7043)!

        /// SwifterSwift: hex #FF5722
        static let deepOrange500			= Color(hex: 0xFF5722)!

        /// SwifterSwift: hex #F4511E
        static let deepOrange600			= Color(hex: 0xF4511E)!

        /// SwifterSwift: hex #E64A19
        static let deepOrange700			= Color(hex: 0xE64A19)!

        /// SwifterSwift: hex #D84315
        static let deepOrange800			= Color(hex: 0xD84315)!

        /// SwifterSwift: hex #BF360C
        static let deepOrange900			= Color(hex: 0xBF360C)!

        /// SwifterSwift: hex #FF9E80
        static let deepOrangeA100		= Color(hex: 0xFF9E80)!

        /// SwifterSwift: hex #FF6E40
        static let deepOrangeA200		= Color(hex: 0xFF6E40)!

        /// SwifterSwift: hex #FF3D00
        static let deepOrangeA400		= Color(hex: 0xFF3D00)!

        /// SwifterSwift: hex #DD2C00
        static let deepOrangeA700		= Color(hex: 0xDD2C00)!

        /// SwifterSwift: color brown500
        static let brown					= brown500

        /// SwifterSwift: hex #EFEBE9
        static let brown50				= Color(hex: 0xEFEBE9)!

        /// SwifterSwift: hex #D7CCC8
        static let brown100				= Color(hex: 0xD7CCC8)!

        /// SwifterSwift: hex #BCAAA4
        static let brown200				= Color(hex: 0xBCAAA4)!

        /// SwifterSwift: hex #A1887F
        static let brown300				= Color(hex: 0xA1887F)!

        /// SwifterSwift: hex #8D6E63
        static let brown400				= Color(hex: 0x8D6E63)!

        /// SwifterSwift: hex #795548
        static let brown500				= Color(hex: 0x795548)!

        /// SwifterSwift: hex #6D4C41
        static let brown600				= Color(hex: 0x6D4C41)!

        /// SwifterSwift: hex #5D4037
        static let brown700				= Color(hex: 0x5D4037)!

        /// SwifterSwift: hex #4E342E
        static let brown800				= Color(hex: 0x4E342E)!

        /// SwifterSwift: hex #3E2723
        static let brown900				= Color(hex: 0x3E2723)!

        /// SwifterSwift: color grey500
        static let grey					= grey500

        /// SwifterSwift: hex #FAFAFA
        static let grey50				= Color(hex: 0xFAFAFA)!

        /// SwifterSwift: hex #F5F5F5
        static let grey100				= Color(hex: 0xF5F5F5)!

        /// SwifterSwift: hex #EEEEEE
        static let grey200				= Color(hex: 0xEEEEEE)!

        /// SwifterSwift: hex #E0E0E0
        static let grey300				= Color(hex: 0xE0E0E0)!

        /// SwifterSwift: hex #BDBDBD
        static let grey400				= Color(hex: 0xBDBDBD)!

        /// SwifterSwift: hex #9E9E9E
        static let grey500				= Color(hex: 0x9E9E9E)!

        /// SwifterSwift: hex #757575
        static let grey600				= Color(hex: 0x757575)!

        /// SwifterSwift: hex #616161
        static let grey700				= Color(hex: 0x616161)!

        /// SwifterSwift: hex #424242
        static let grey800				= Color(hex: 0x424242)!

        /// SwifterSwift: hex #212121
        static let grey900				= Color(hex: 0x212121)!

        /// SwifterSwift: color blueGrey500
        static let blueGrey				= blueGrey500

        /// SwifterSwift: hex #ECEFF1
        static let blueGrey50			= Color(hex: 0xECEFF1)!

        /// SwifterSwift: hex #CFD8DC
        static let blueGrey100			= Color(hex: 0xCFD8DC)!

        /// SwifterSwift: hex #B0BEC5
        static let blueGrey200			= Color(hex: 0xB0BEC5)!

        /// SwifterSwift: hex #90A4AE
        static let blueGrey300			= Color(hex: 0x90A4AE)!

        /// SwifterSwift: hex #78909C
        static let blueGrey400			= Color(hex: 0x78909C)!

        /// SwifterSwift: hex #607D8B
        static let blueGrey500			= Color(hex: 0x607D8B)!

        /// SwifterSwift: hex #546E7A
        static let blueGrey600			= Color(hex: 0x546E7A)!

        /// SwifterSwift: hex #455A64
        static let blueGrey700			= Color(hex: 0x455A64)!

        /// SwifterSwift: hex #37474F
        static let blueGrey800			= Color(hex: 0x37474F)!

        /// SwifterSwift: hex #263238
        static let blueGrey900			= Color(hex: 0x263238)!

        /// SwifterSwift: hex #000000
        static let black					= Color(hex: 0x000000)!

        /// SwifterSwift: hex #FFFFFF
        static let white					= Color(hex: 0xFFFFFF)!
    }

}

// MARK: - CSS colors
public extension Color {

    /// CSS colors.
    struct CSS {
        // http://www.w3schools.com/colors/colors_names.asp

        /// SwifterSwift: hex #F0F8FF
        static let aliceBlue				= Color(hex: 0xF0F8FF)!

        /// SwifterSwift: hex #FAEBD7
        static let antiqueWhite			= Color(hex: 0xFAEBD7)!

        /// SwifterSwift: hex #00FFFF
        static let aqua					= Color(hex: 0x00FFFF)!

        /// SwifterSwift: hex #7FFFD4
        static let aquamarine			= Color(hex: 0x7FFFD4)!

        /// SwifterSwift: hex #F0FFFF
        static let azure					= Color(hex: 0xF0FFFF)!

        /// SwifterSwift: hex #F5F5DC
        static let beige					= Color(hex: 0xF5F5DC)!

        /// SwifterSwift: hex #FFE4C4
        static let bisque				= Color(hex: 0xFFE4C4)!

        /// SwifterSwift: hex #000000
        static let black					= Color(hex: 0x000000)!

        /// SwifterSwift: hex #FFEBCD
        static let blanchedAlmond		= Color(hex: 0xFFEBCD)!

        /// SwifterSwift: hex #0000FF
        static let blue					= Color(hex: 0x0000FF)!

        /// SwifterSwift: hex #8A2BE2
        static let blueViolet			= Color(hex: 0x8A2BE2)!

        /// SwifterSwift: hex #A52A2A
        static let brown					= Color(hex: 0xA52A2A)!

        /// SwifterSwift: hex #DEB887
        static let burlyWood				= Color(hex: 0xDEB887)!

        /// SwifterSwift: hex #5F9EA0
        static let cadetBlue				= Color(hex: 0x5F9EA0)!

        /// SwifterSwift: hex #7FFF00
        static let chartreuse			= Color(hex: 0x7FFF00)!

        /// SwifterSwift: hex #D2691E
        static let chocolate				= Color(hex: 0xD2691E)!

        /// SwifterSwift: hex #FF7F50
        static let coral					= Color(hex: 0xFF7F50)!

        /// SwifterSwift: hex #6495ED
        static let cornflowerBlue		= Color(hex: 0x6495ED)!

        /// SwifterSwift: hex #FFF8DC
        static let cornsilk				= Color(hex: 0xFFF8DC)!

        /// SwifterSwift: hex #DC143C
        static let crimson				= Color(hex: 0xDC143C)!

        /// SwifterSwift: hex #00FFFF
        static let cyan					= Color(hex: 0x00FFFF)!

        /// SwifterSwift: hex #00008B
        static let darkBlue				= Color(hex: 0x00008B)!

        /// SwifterSwift: hex #008B8B
        static let darkCyan				= Color(hex: 0x008B8B)!

        /// SwifterSwift: hex #B8860B
        static let darkGoldenRod			= Color(hex: 0xB8860B)!

        /// SwifterSwift: hex #A9A9A9
        static let darkGray				= Color(hex: 0xA9A9A9)!

        /// SwifterSwift: hex #A9A9A9
        static let darkGrey				= Color(hex: 0xA9A9A9)!

        /// SwifterSwift: hex #006400
        static let darkGreen				= Color(hex: 0x006400)!

        /// SwifterSwift: hex #BDB76B
        static let darkKhaki				= Color(hex: 0xBDB76B)!

        /// SwifterSwift: hex #8B008B
        static let darkMagenta			= Color(hex: 0x8B008B)!

        /// SwifterSwift: hex #556B2F
        static let darkOliveGreen		= Color(hex: 0x556B2F)!

        /// SwifterSwift: hex #FF8C00
        static let darkOrange			= Color(hex: 0xFF8C00)!

        /// SwifterSwift: hex #9932CC
        static let darkOrchid			= Color(hex: 0x9932CC)!

        /// SwifterSwift: hex #8B0000
        static let darkRed				= Color(hex: 0x8B0000)!

        /// SwifterSwift: hex #E9967A
        static let darkSalmon			= Color(hex: 0xE9967A)!

        /// SwifterSwift: hex #8FBC8F
        static let darkSeaGreen			= Color(hex: 0x8FBC8F)!

        /// SwifterSwift: hex #483D8B
        static let darkSlateBlue			= Color(hex: 0x483D8B)!

        /// SwifterSwift: hex #2F4F4F
        static let darkSlateGray			= Color(hex: 0x2F4F4F)!

        /// SwifterSwift: hex #2F4F4F
        static let darkSlateGrey			= Color(hex: 0x2F4F4F)!

        /// SwifterSwift: hex #00CED1
        static let darkTurquoise			= Color(hex: 0x00CED1)!

        /// SwifterSwift: hex #9400D3
        static let darkViolet			= Color(hex: 0x9400D3)!

        /// SwifterSwift: hex #FF1493
        static let deepPink				= Color(hex: 0xFF1493)!

        /// SwifterSwift: hex #00BFFF
        static let deepSkyBlue			= Color(hex: 0x00BFFF)!

        /// SwifterSwift: hex #696969
        static let dimGray				= Color(hex: 0x696969)!

        /// SwifterSwift: hex #696969
        static let dimGrey				= Color(hex: 0x696969)!

        /// SwifterSwift: hex #1E90FF
        static let dodgerBlue			= Color(hex: 0x1E90FF)!

        /// SwifterSwift: hex #B22222
        static let fireBrick				= Color(hex: 0xB22222)!

        /// SwifterSwift: hex #FFFAF0
        static let floralWhite			= Color(hex: 0xFFFAF0)!

        /// SwifterSwift: hex #228B22
        static let forestGreen			= Color(hex: 0x228B22)!

        /// SwifterSwift: hex #FF00FF
        static let fuchsia				= Color(hex: 0xFF00FF)!

        /// SwifterSwift: hex #DCDCDC
        static let gainsboro				= Color(hex: 0xDCDCDC)!

        /// SwifterSwift: hex #F8F8FF
        static let ghostWhite			= Color(hex: 0xF8F8FF)!

        /// SwifterSwift: hex #FFD700
        static let gold					= Color(hex: 0xFFD700)!

        /// SwifterSwift: hex #DAA520
        static let goldenRod				= Color(hex: 0xDAA520)!

        /// SwifterSwift: hex #808080
        static let gray					= Color(hex: 0x808080)!

        /// SwifterSwift: hex #808080
        static let grey					= Color(hex: 0x808080)!

        /// SwifterSwift: hex #008000
        static let green					= Color(hex: 0x008000)!

        /// SwifterSwift: hex #ADFF2F
        static let greenYellow			= Color(hex: 0xADFF2F)!

        /// SwifterSwift: hex #F0FFF0
        static let honeyDew				= Color(hex: 0xF0FFF0)!

        /// SwifterSwift: hex #FF69B4
        static let hotPink				= Color(hex: 0xFF69B4)!

        /// SwifterSwift: hex #CD5C5C
        static let indianRed				= Color(hex: 0xCD5C5C)!

        /// SwifterSwift: hex #4B0082
        static let indigo				= Color(hex: 0x4B0082)!

        /// SwifterSwift: hex #FFFFF0
        static let ivory					= Color(hex: 0xFFFFF0)!

        /// SwifterSwift: hex #F0E68C
        static let khaki					= Color(hex: 0xF0E68C)!

        /// SwifterSwift: hex #E6E6FA
        static let lavender				= Color(hex: 0xE6E6FA)!

        /// SwifterSwift: hex #FFF0F5
        static let lavenderBlush			= Color(hex: 0xFFF0F5)!

        /// SwifterSwift: hex #7CFC00
        static let lawnGreen				= Color(hex: 0x7CFC00)!

        /// SwifterSwift: hex #FFFACD
        static let lemonChiffon			= Color(hex: 0xFFFACD)!

        /// SwifterSwift: hex #ADD8E6
        static let lightBlue				= Color(hex: 0xADD8E6)!

        /// SwifterSwift: hex #F08080
        static let lightCoral			= Color(hex: 0xF08080)!

        /// SwifterSwift: hex #E0FFFF
        static let lightCyan				= Color(hex: 0xE0FFFF)!

        /// SwifterSwift: hex #FAFAD2
        static let lightGoldenRodYellow	= Color(hex: 0xFAFAD2)!

        /// SwifterSwift: hex #D3D3D3
        static let lightGray				= Color(hex: 0xD3D3D3)!

        /// SwifterSwift: hex #D3D3D3
        static let lightGrey				= Color(hex: 0xD3D3D3)!

        /// SwifterSwift: hex #90EE90
        static let lightGreen			= Color(hex: 0x90EE90)!

        /// SwifterSwift: hex #FFB6C1
        static let lightPink				= Color(hex: 0xFFB6C1)!

        /// SwifterSwift: hex #FFA07A
        static let lightSalmon			= Color(hex: 0xFFA07A)!

        /// SwifterSwift: hex #20B2AA
        static let lightSeaGreen			= Color(hex: 0x20B2AA)!

        /// SwifterSwift: hex #87CEFA
        static let lightSkyBlue			= Color(hex: 0x87CEFA)!

        /// SwifterSwift: hex #778899
        static let lightSlateGray		= Color(hex: 0x778899)!

        /// SwifterSwift: hex #778899
        static let lightSlateGrey		= Color(hex: 0x778899)!

        /// SwifterSwift: hex #B0C4DE
        static let lightSteelBlue		= Color(hex: 0xB0C4DE)!

        /// SwifterSwift: hex #FFFFE0
        static let lightYellow			= Color(hex: 0xFFFFE0)!

        /// SwifterSwift: hex #00FF00
        static let lime					= Color(hex: 0x00FF00)!

        /// SwifterSwift: hex #32CD32
        static let limeGreen				= Color(hex: 0x32CD32)!

        /// SwifterSwift: hex #FAF0E6
        static let linen					= Color(hex: 0xFAF0E6)!

        /// SwifterSwift: hex #FF00FF
        static let magenta				= Color(hex: 0xFF00FF)!

        /// SwifterSwift: hex #800000
        static let maroon				= Color(hex: 0x800000)!

        /// SwifterSwift: hex #66CDAA
        static let mediumAquaMarine		= Color(hex: 0x66CDAA)!

        /// SwifterSwift: hex #0000CD
        static let mediumBlue			= Color(hex: 0x0000CD)!

        /// SwifterSwift: hex #BA55D3
        static let mediumOrchid			= Color(hex: 0xBA55D3)!

        /// SwifterSwift: hex #9370DB
        static let mediumPurple			= Color(hex: 0x9370DB)!

        /// SwifterSwift: hex #3CB371
        static let mediumSeaGreen		= Color(hex: 0x3CB371)!

        /// SwifterSwift: hex #7B68EE
        static let mediumSlateBlue		= Color(hex: 0x7B68EE)!

        /// SwifterSwift: hex #00FA9A
        static let mediumSpringGreen		= Color(hex: 0x00FA9A)!

        /// SwifterSwift: hex #48D1CC
        static let mediumTurquoise		= Color(hex: 0x48D1CC)!

        /// SwifterSwift: hex #C71585
        static let mediumVioletRed		= Color(hex: 0xC71585)!

        /// SwifterSwift: hex #191970
        static let midnightBlue			= Color(hex: 0x191970)!

        /// SwifterSwift: hex #F5FFFA
        static let mintCream				= Color(hex: 0xF5FFFA)!

        /// SwifterSwift: hex #FFE4E1
        static let mistyRose				= Color(hex: 0xFFE4E1)!

        /// SwifterSwift: hex #FFE4B5
        static let moccasin				= Color(hex: 0xFFE4B5)!

        /// SwifterSwift: hex #FFDEAD
        static let navajoWhite			= Color(hex: 0xFFDEAD)!

        /// SwifterSwift: hex #000080
        static let navy					= Color(hex: 0x000080)!

        /// SwifterSwift: hex #FDF5E6
        static let oldLace				= Color(hex: 0xFDF5E6)!

        /// SwifterSwift: hex #808000
        static let olive					= Color(hex: 0x808000)!

        /// SwifterSwift: hex #6B8E23
        static let oliveDrab				= Color(hex: 0x6B8E23)!

        /// SwifterSwift: hex #FFA500
        static let orange				= Color(hex: 0xFFA500)!

        /// SwifterSwift: hex #FF4500
        static let orangeRed				= Color(hex: 0xFF4500)!

        /// SwifterSwift: hex #DA70D6
        static let orchid				= Color(hex: 0xDA70D6)!

        /// SwifterSwift: hex #EEE8AA
        static let paleGoldenRod			= Color(hex: 0xEEE8AA)!

        /// SwifterSwift: hex #98FB98
        static let paleGreen				= Color(hex: 0x98FB98)!

        /// SwifterSwift: hex #AFEEEE
        static let paleTurquoise			= Color(hex: 0xAFEEEE)!

        /// SwifterSwift: hex #DB7093
        static let paleVioletRed			= Color(hex: 0xDB7093)!

        /// SwifterSwift: hex #FFEFD5
        static let papayaWhip			= Color(hex: 0xFFEFD5)!

        /// SwifterSwift: hex #FFDAB9
        static let peachPuff				= Color(hex: 0xFFDAB9)!

        /// SwifterSwift: hex #CD853F
        static let peru					= Color(hex: 0xCD853F)!

        /// SwifterSwift: hex #FFC0CB
        static let pink					= Color(hex: 0xFFC0CB)!

        /// SwifterSwift: hex #DDA0DD
        static let plum					= Color(hex: 0xDDA0DD)!

        /// SwifterSwift: hex #B0E0E6
        static let powderBlue			= Color(hex: 0xB0E0E6)!

        /// SwifterSwift: hex #800080
        static let purple				= Color(hex: 0x800080)!

        /// SwifterSwift: hex #663399
        static let rebeccaPurple			= Color(hex: 0x663399)!

        /// SwifterSwift: hex #FF0000
        static let red					= Color(hex: 0xFF0000)!

        /// SwifterSwift: hex #BC8F8F
        static let rosyBrown				= Color(hex: 0xBC8F8F)!

        /// SwifterSwift: hex #4169E1
        static let royalBlue				= Color(hex: 0x4169E1)!

        /// SwifterSwift: hex #8B4513
        static let saddleBrown			= Color(hex: 0x8B4513)!

        /// SwifterSwift: hex #FA8072
        static let salmon				= Color(hex: 0xFA8072)!

        /// SwifterSwift: hex #F4A460
        static let sandyBrown			= Color(hex: 0xF4A460)!

        /// SwifterSwift: hex #2E8B57
        static let seaGreen				= Color(hex: 0x2E8B57)!

        /// SwifterSwift: hex #FFF5EE
        static let seaShell				= Color(hex: 0xFFF5EE)!

        /// SwifterSwift: hex #A0522D
        static let sienna				= Color(hex: 0xA0522D)!

        /// SwifterSwift: hex #C0C0C0
        static let silver				= Color(hex: 0xC0C0C0)!

        /// SwifterSwift: hex #87CEEB
        static let skyBlue				= Color(hex: 0x87CEEB)!

        /// SwifterSwift: hex #6A5ACD
        static let slateBlue				= Color(hex: 0x6A5ACD)!

        /// SwifterSwift: hex #708090
        static let slateGray				= Color(hex: 0x708090)!

        /// SwifterSwift: hex #708090
        static let slateGrey				= Color(hex: 0x708090)!

        /// SwifterSwift: hex #FFFAFA
        static let snow					= Color(hex: 0xFFFAFA)!

        /// SwifterSwift: hex #00FF7F
        static let springGreen			= Color(hex: 0x00FF7F)!

        /// SwifterSwift: hex #4682B4
        static let steelBlue				= Color(hex: 0x4682B4)!

        /// SwifterSwift: hex #D2B48C
        static let tan					= Color(hex: 0xD2B48C)!

        /// SwifterSwift: hex #008080
        static let teal					= Color(hex: 0x008080)!

        /// SwifterSwift: hex #D8BFD8
        static let thistle				= Color(hex: 0xD8BFD8)!

        /// SwifterSwift: hex #FF6347
        static let tomato				= Color(hex: 0xFF6347)!

        /// SwifterSwift: hex #40E0D0
        static let turquoise				= Color(hex: 0x40E0D0)!

        /// SwifterSwift: hex #EE82EE
        static let violet				= Color(hex: 0xEE82EE)!

        /// SwifterSwift: hex #F5DEB3
        static let wheat					= Color(hex: 0xF5DEB3)!

        /// SwifterSwift: hex #FFFFFF
        static let white					= Color(hex: 0xFFFFFF)!

        /// SwifterSwift: hex #F5F5F5
        static let whiteSmoke			= Color(hex: 0xF5F5F5)!

        /// SwifterSwift: hex #FFFF00
        static let yellow				= Color(hex: 0xFFFF00)!

        /// SwifterSwift: hex #9ACD32
        static let yellowGreen			= Color(hex: 0x9ACD32)!
    }

}

// MARK: - Flat UI colors
public extension Color {

    /// 平面UI颜色
    struct FlatUI {
        // http://flatuicolors.com.

        /// SwifterSwift: hex #1ABC9C
        static let turquoise             = Color(hex: 0x1abc9c)!

        /// SwifterSwift: hex #16A085
        static let greenSea              = Color(hex: 0x16a085)!

        /// SwifterSwift: hex #2ECC71
        static let emerald               = Color(hex: 0x2ecc71)!

        /// SwifterSwift: hex #27AE60
        static let nephritis             = Color(hex: 0x27ae60)!

        /// SwifterSwift: hex #3498DB
        static let peterRiver            = Color(hex: 0x3498db)!

        /// SwifterSwift: hex #2980B9
        static let belizeHole            = Color(hex: 0x2980b9)!

        /// SwifterSwift: hex #9B59B6
        static let amethyst              = Color(hex: 0x9b59b6)!

        /// SwifterSwift: hex #8E44AD
        static let wisteria              = Color(hex: 0x8e44ad)!

        /// SwifterSwift: hex #34495E
        static let wetAsphalt            = Color(hex: 0x34495e)!

        /// SwifterSwift: hex #2C3E50
        static let midnightBlue          = Color(hex: 0x2c3e50)!

        /// SwifterSwift: hex #F1C40F
        static let sunFlower             = Color(hex: 0xf1c40f)!

        /// SwifterSwift: hex #F39C12
        static let flatOrange            = Color(hex: 0xf39c12)!

        /// SwifterSwift: hex #E67E22
        static let carrot                = Color(hex: 0xe67e22)!

        /// SwifterSwift: hex #D35400
        static let pumkin                = Color(hex: 0xd35400)!

        /// SwifterSwift: hex #E74C3C
        static let alizarin              = Color(hex: 0xe74c3c)!

        /// SwifterSwift: hex #C0392B
        static let pomegranate           = Color(hex: 0xc0392b)!

        /// SwifterSwift: hex #ECF0F1
        static let clouds                = Color(hex: 0xecf0f1)!

        /// SwifterSwift: hex #BDC3C7
        static let silver                = Color(hex: 0xbdc3c7)!

        /// SwifterSwift: hex #7F8C8D
        static let asbestos              = Color(hex: 0x7f8c8d)!

        /// SwifterSwift: hex #95A5A6
        static let concerte              = Color(hex: 0x95a5a6)!
    }

}
#endif
