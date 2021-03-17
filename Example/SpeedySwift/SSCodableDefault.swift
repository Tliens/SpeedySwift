//
//  SSCodableDefault.swift
//  SpeedySwift_Example
//
//  Created by 2020 on 2021/3/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Foundation
typealias SSCBD = SSCodableDefault

@propertyWrapper
struct SSCodableDefault<T: SSCodableDefaultValue> {
     var wrappedValue: T.defalut
}

extension SSCodableDefault: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.defalut.self)) ?? T.defaultValue
    }

}
extension KeyedDecodingContainer {
    func decode<T>(
        _ type: SSCodableDefault<T>.Type,
        forKey key: Key
    ) throws -> SSCodableDefault<T> where T: SSCodableDefaultValue {
        try decodeIfPresent(type, forKey: key) ?? SSCodableDefault(wrappedValue: T.defaultValue)
    }
}

extension KeyedEncodingContainer{
    func encode<T>(
        _ type: SSCodableDefault<T>.Type,
        forKey key: Key
    ) throws -> SSCodableDefault<T> where T: SSCodableDefaultValue {
        
        try encode(type, forKey: key)
    }
}
public protocol SSCodableDefaultValue {
    associatedtype defalut: Codable
    static var defaultValue: defalut { get }
}

// MARK:基础数据类型 遵守DefaultValue
extension Bool: SSCodableDefaultValue {
    public static let defaultValue = false
}
extension String: SSCodableDefaultValue {
    public static let defaultValue = ""
}
extension Double: SSCodableDefaultValue {
    public static let defaultValue = -1
}
extension Int: SSCodableDefaultValue {
    public static let defaultValue = -1
}
extension Float: SSCodableDefaultValue {
    public static let defaultValue = -1
}
