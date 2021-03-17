# SpeedySwift
[![Pods](https://img.shields.io/cocoapods/v/SpeedySwift.svg)](https://cocoapods.org/pods/SpeedySwift)
[![Build Status](https://travis-ci.org/ios_base_foundation/SnapKit.svg)](https://travis-ci.org/ios_base_foundation/ios_base_foundation)
[![Sponsors](https://opencollective.com/ios_base_foundation/sponsors/badge.svg)](https://opencollective.com/ios_base_foundation/sponsors/badge.svg)
[![LICENSE](https://img.shields.io/cocoapods/l/ios_base_foundation.svg)](https://img.shields.io/cocoapods/l/ios_base_foundation.svg)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)

这是一个app开发的加速库，我的几款app都是基于这个加速库完成的

 - 《imi-成就》https://apps.apple.com/cn/app/id1543829703

 - 《今日计划》https://apps.apple.com/cn/app/id1505020317


尽量保持开发的原汁原味，欢迎使用，喜欢star✨

我想目前Swift中没有比这个更合适的加速开发app的框架了，如果有请告诉我。

它也是进阶Swift的非常好的代码参考，如果你是独立开发者，那一定会让你惊喜的。

![img](https://github.com/Tliens/SpeedySwift/blob/master/icon_0.png)

## 2021-03-17 更新

- 支持cocoapods
- 完善类、方法权限关键字
- 去除不合适的第三方库
- 修改文件结构
- 增加使用示例


## 特色：

- 属性包裹器，包含 [喵神 的使用 Property Wrapper 为 Codable 解码设定默认值](https://mp.weixin.qq.com/s/jOyHRS2Wx6MJpuYuENhVgg)
- 属性包裹器，UserDefault的使用
- UI适配终结，UI+Scale.swift
- [SwifterSwift 的常用函数（我去除了很多不常用的东西）](https://github.com/SwifterSwift/SwifterSwift)
- app 跳转、Viewcontrolle、NavigationController、TabbarController都实现了基础封装
- 网络监察、截屏监听、弹窗管理、沙盒缓存
- 基本的app信息、bundleID、displayName、version等
- 7种震动反馈

## 如何使用

## Pod导入
```
pod 'SpeedySwift'
```

要求：`Swift5.0`及以上

## 代码演示

- 颜色
```
UIColor.hex("#22023b")
```
- 底部安全区高度
```
let height = SS.safeBottomHeight
```
- 不用关心方向的 SSCollectionViewLayout
```
let layout = SSCollectionViewLayout(longitude: 0, latitude: 10.scale, itemSize: CGSize(width: 130.scale, height: 139.scale), sectionInset: .init(top: 10.scale, left: 20.scale, bottom: 0, right: 20.scale), direction: .vertical)
```
- 属性包裹器
```
/// codable👍
@Default<String.defalut> var name:String

/// 数据持久化👍
@UserDefault("had_shown_guide_view", defaultValue: false)
static var hadShownGuideView: Bool

```
- 系统页跳转
```
/// 跳转到系统页面
static func systemJump(completionHandler completion: ((AppJumpStatus) -> Void)? = nil){
    let urlString = UIApplication.openSettingsURLString
    if let url: URL = URL(string: urlString) {
        App.jump(url: url, completionHandler: completion)
    }else{
        completion?(.fail)
    }
}
```
- 增加通过cell上的控件获取cell、index
```
    /// 获取indexpath
    func indexPath(by child:UIView)->IndexPath?{
        let point = child.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: point)
    }
    /// 获取cell
    func cell(by child:UIView)->UITableViewCell?{
        let point = child.convert(CGPoint.zero, to: self)
        if let indexPath = self.indexPathForRow(at: point){
            return self.cellForRow(at: indexPath)
        }
        return nil
    }

```
- 其他
```
	/// app版本号
    static var version: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    /// 设备名称
    static var deviceName: String {
        return UIDevice.current.localizedModel
    }
    /// 设备方向
    static var deviceOrientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    /// 主窗口
    static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }
    /// 当前系统版本
    static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    /// 判断设备是不是iPhoneX
    static var isX : Bool {
        var isX = false
        if #available(iOS 11.0, *) {
            let bottom : CGFloat = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
            isX = bottom > 0.0
        }
        return isX
    }
```

等你发现更多······

欢迎使用，喜欢请star✨

## 目录
- Base：此文件夹中是基础类
- Core：此文件夹中是UIKit+Foundation的扩展，建议你自己维护一套
- SS.swift 是比较核心的类，为其增加了很多extension，方便快速使用，如：SS.log、SS.bundleID、SS.safeBottomHeight、SS.toast、SS.between...
- SSDefault 属性包裹器的具体分装
- SSCodableDefault 因为 权限问题没能解决，无法放到pod中，如果你有办法可以提交代码。
```
class Member:Codable {
    @SSCBD<Bool.defalut> var isOk:Bool
    @SSCBD<String.defalut> var name:String
    @SSCBD<Int.defalut> var age:Int
}
```
- SSSandBox 沙盒相关操作
- Tools 此文件夹中，包含：app之间跳转、网络检查、弹窗、震动反馈


### 微信公众号：独立开发者基地 

> 分享我的独立开发的故事，经验； Share stories and experiences of independent development.

<div  align="center">    
<img src="https://github.com/Tliens/SpeedySwift/blob/master/WechatIMG58.jpeg" width = "335" height = "388" alt="公众号" align=center />
</div>

