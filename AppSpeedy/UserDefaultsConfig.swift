//
//  UserDefaultsConfig.swift
//  App1125
//
//  Created by 2020 on 2020/12/10.
//

import Foundation
typealias UD = UserDefaultsConfig
struct UserDefaultsConfig {
    @UserDefault("theme_mode", defaultValue: 1)
    static var themeMode: Int
    
}

//
/////具体的业务代码。
//UserDefaultsConfig.hadShownGuideView = false
//print(UserDefaultsConfig.hadShownGuideView) // false
//UserDefaultsConfig.hadShownGuideView = true
//print(UserDefaultsConfig.hadShownGuideView) // true
