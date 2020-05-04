//
//  SignedNumberpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/15/17.
//  Copyright © 2017 SpeedySwift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension SignedNumeric {

    /// 转string
     var string: String {
        return String(describing: self)
    }

    #if canImport(Foundation)
    /// 带有数字和当前语言环境货币的字符串。
    var asLocaleCurrency: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        // swiftlint:disable next force_cast
        return formatter.string(from: self as! NSNumber)
    }
    #endif

}

// MARK: - Methods
public extension SignedNumeric {

    #if canImport(Foundation)
    /// 数字转语言
    ///
    ///        print((12.32).spelledOutString()) // prints "twelve point three two"
    ///
    /// - Parameter locale: Locale, default is .current.
    /// - Returns: String representation of number spelled in specified locale language. E.g. input 92, output in "en": "ninety-two"
    func spelledOutString(locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .spellOut

        guard let number = self as? NSNumber else { return nil }
        return formatter.string(from: number)
    }
    #endif

}
