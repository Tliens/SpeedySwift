//
//  AppUserDefault.swift
//  BeerGame
//
//  Created by Quinn on 2020/11/14.
//


import Foundation
@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T

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
//
/////封装一个UserDefault配置文件
//struct UserDefaultsConfig {
/////告诉编译器 我要包裹的是hadShownGuideView这个值。
/////实际写法就是在UserDefault包裹器的初始化方法前加了个@
///// hadShownGuideView 属性的一些key和默认值已经在 UserDefault包裹器的构造方法中实现
//  @UserDefault("had_shown_guide_view", defaultValue: false)
//  static var hadShownGuideView: Bool
//}
//
/////具体的业务代码。
//UserDefaultsConfig.hadShownGuideView = false
//print(UserDefaultsConfig.hadShownGuideView) // false
//UserDefaultsConfig.hadShownGuideView = true
//print(UserDefaultsConfig.hadShownGuideView) // true


