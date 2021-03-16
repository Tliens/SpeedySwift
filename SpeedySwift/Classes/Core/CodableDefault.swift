//
//  AppCodableDefault.swift
//  SpeedySwift
//
//  Created by Quinn on 2020/11/19.
//

import Foundation
@propertyWrapper
struct Default<T: DefaultValue> {
    public var wrappedValue: T.defalut
}

extension Default: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.defalut.self)) ?? T.defaultValue
    }

}
extension KeyedDecodingContainer {
    func decode<T>(
        _ type: Default<T>.Type,
        forKey key: Key
    ) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

extension KeyedEncodingContainer{
    func encode<T>(
        _ type: Default<T>.Type,
        forKey key: Key
    ) throws -> Default<T> where T: DefaultValue {
        
        try encode(type, forKey: key)
    }
}
public protocol DefaultValue {
    associatedtype defalut: Codable
    static var defaultValue: defalut { get }
}

// MARK:基础数据类型 遵守DefaultValue
extension Bool: DefaultValue {
    public static let defaultValue = false
}
extension String: DefaultValue {
    public static let defaultValue = ""
}
extension Double: DefaultValue {
    public static let defaultValue = -1
}
extension Int: DefaultValue {
    public static let defaultValue = -1
}
extension Float: DefaultValue {
    public static let defaultValue = -1
}

//MARK:Test
//class Member:Codable {
//    @Default<Bool.defalut> var isOk:Bool
//    @Default<String.defalut> var name:String
//    var age:Int!
//}
