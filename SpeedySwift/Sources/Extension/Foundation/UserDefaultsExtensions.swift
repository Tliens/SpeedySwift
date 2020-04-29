//
//  UserDefaultsExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 9/5/17.
//  Copyright © 2017 SpeedySwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Methods
public extension UserDefaults {

    /// 通过使用下标从UserDefaults获取对象
    ///
    /// - Parameter key: key in the current user's defaults database.
    public subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    /// 从UserDefaults获取Float。
    ///
    /// - Parameter forKey: key to find float for.
    /// - Returns: Float object for key (if exists).
    public func float(forKey key: String) -> Float? {
        return object(forKey: key) as? Float
    }

    /// 从UserDefaults获取Date
    ///
    /// - Parameter forKey: key to find date for.
    /// - Returns: Date object for key (if exists).
    public func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }

    ///从UserDefaults中检索一个可编码的对象。
    ///
    /// - Parameters:
    ///   - type: Class that conforms to the Codable protocol.
    ///   - key: Identifier of the object.
    ///   - decoder: Custom JSONDecoder instance. Defaults to `JSONDecoder()`.
    /// - Returns: Codable object for key (if exists).
    public func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    /// 允许将可编程对象存储为UserDefaults。
    ///
    /// - Parameters:
    ///   - object: Codable object to store.
    ///   - key: Identifier of the object.
    ///   - encoder: Custom JSONEncoder instance. Defaults to `JSONEncoder()`.
    public func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }

}
#endif
