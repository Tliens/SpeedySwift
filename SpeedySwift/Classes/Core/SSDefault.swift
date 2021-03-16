//
//  AppUserDefault.swift
//  SpeedySwift
//
//  Created by Quinn on 2020/11/14.
//


import Foundation
@propertyWrapper
public struct SSDefault<T> {
    public let key: String
    public let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}


//MARK: 使用示例

/// 封装一个SSUserDefault配置文件
//struct AppDefault {
//  @SSDefault("had_shown_guide_view", defaultValue: false)
//  static var hadShownGuideView: Bool
//}
//
//class Solution{
//    func demo(){
//        AppDefault.hadShownGuideView = false
//        print(AppDefault.hadShownGuideView)
//    }
//}



