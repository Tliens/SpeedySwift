//
//  Dictionarypublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 8/24/16.
//  Copyright © 2016 SpeedySwift
//

import Foundation

// MARK: - Methods
public extension Dictionary {

    /// key是否存在在字典中
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    /// 移除key对应的value
    mutating func removeAll<S: Sequence>(keys: S) where S.Element == Key {
        keys.forEach { removeValue(forKey: $0) }
    }

    /// 从字典中移除一个随意的key
    @discardableResult mutating func removeValueForRandomKey() -> Value? {
        guard let randomKey = keys.randomElement() else { return nil }
        return removeValue(forKey: randomKey)
    }

    /// 字典转Data
    func toData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }

    /// 字典转json
    func toJson(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}
