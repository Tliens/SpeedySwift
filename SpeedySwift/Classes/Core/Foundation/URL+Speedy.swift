//
//  URL+Speedy.swift
//  SpeedySwift
//
//  Created by 2020 on 2022/5/2.
//

import Foundation
public extension URL {
    var urlParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
        let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
