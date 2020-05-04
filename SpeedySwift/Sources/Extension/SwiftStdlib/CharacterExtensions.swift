//
//  Characterpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/8/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension Character {

    /// 检查字符是否是emoji
    ///
    ///        Character("😀").isEmoji -> true
    ///
    var  isEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        let scalarValue = String(self).unicodeScalars.first!.value
        switch scalarValue {
        case 0x3030, 0x00AE, 0x00A9, // Special Characters
        0x1D000...0x1F77F, // Emoticons
        0x2100...0x27BF, // Misc symbols and Dingbats
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
            return true
        default:
            return false
        }
    }

    /// 检查是否是数字.
    ///
    ///        Character("1").isNumber -> true
    ///        Character("a").isNumber -> false
    ///
    var  isNumber: Bool {
        return Int(String(self)) != nil
    }

    /// 检查是否是字母
    ///
    ///        Character("4").isLetter -> false
    ///        Character("a").isLetter -> true
    ///
    var  isLetter: Bool {
        return String(self).rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }

    /// 检查字符是否为小写
    ///
    ///        Character("a").isLowercased -> true
    ///        Character("A").isLowercased -> false
    ///
    var  isLowercased: Bool {
        return String(self) == String(self).lowercased()
    }

    /// 检查字符是否是大写
    ///
    ///        Character("a").isUppercased -> false
    ///        Character("A").isUppercased -> true
    ///
    var  isUppercased: Bool {
        return String(self) == String(self).uppercased()
    }

    /// 检查字符是否为空
    ///
    ///        Character(" ").isWhiteSpace -> true
    ///        Character("A").isWhiteSpace -> false
    ///
    var  isWhiteSpace: Bool {
        return String(self) == " "
    }

    /// 检查字符是否可以转Int
    ///
    ///        Character("1").int -> 1
    ///        Character("A").int -> nil
    ///
    var  int: Int? {
        return Int(String(self))
    }

    /// 字符转字符串
    ///
    ///        Character("a").string -> "a"
    ///
    var  string: String {
        return String(self)
    }

    /// 转小写
    ///
    ///        Character("A").lowercased -> Character("a")
    ///
    var  lowercased: Character {
        return String(self).lowercased().first!
    }

    /// 转大写
    ///
    ///        Character("a").uppercased -> Character("A")
    ///
    var  uppercased: Character {
        return String(self).uppercased().first!
    }

}

// MARK: - Methods
public extension Character {

    #if canImport(Foundation)
    /// 随机字符串
    ///
    ///    Character.random() -> k
    ///
    /// - Returns: A random character.
    static func randomAlphanumeric() -> Character {
        return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()!
    }
    #endif

}

// MARK: - Operators
public extension Character {

    /// 字符串复制
    ///
    ///        Character("-") * 10 -> "----------"
    ///
    /// - Parameters:
    ///   - lhs: character to repeat.
    ///   - rhs: number of times to repeat character.
    /// - Returns: string with character repeated n times.
    static func * (lhs: Character, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: String(lhs), count: rhs)
    }

    ///字符串复制
    ///
    ///        10 * Character("-") -> "----------"
    ///
    /// - Parameters:
    ///   - lhs: number of times to repeat character.
    ///   - rhs: character to repeat.
    /// - Returns: string with character repeated n times.
    static func * (lhs: Int, rhs: Character) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: String(rhs), count: lhs)
    }

}
