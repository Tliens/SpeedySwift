# SpeedySwift
> 这是一个app开发的加速库，我的几款app都是基于这个加速库完成的《今日计划》《今日扫雷》《喝酒游戏》《神盾局》等。

尽量保持开发的原汁原味，欢迎使用，喜欢star✨

我想目前Swift中没有比这个更合适的加速开发app的框架了，如果有请告诉我。

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

下载最新代码后，将AppSpeedy拖入到工程中，暂不支持pod

要求：Swift5.0及以上

## 代码演示

- 颜色
```
UIColor.hex("#22023b")
```
- 底部安全区高度
```
let height = App.safeBottomHeight
```
- 字符串提取
```
"Hello World!"[safe: 3] -> "l"
```
- 不用关心方向的 AppCollectionViewLayout
```
let layout = AppCollectionViewLayout(longitude: 0, latitude: 10.scale, itemSize: CGSize(width: 130.scale, height: 139.scale), sectionInset: .init(top: 10.scale, left: 20.scale, bottom: 0, right: 20.scale), direction: .vertical)
```
欢迎使用，喜欢请star✨

## 结构介绍

我根据使用频率以及层次结构分为了：
- O1_Base
- O2_Core
- O3_Foundation
- O4_UI
- O5_Vendor
- O6_Resource

O1_Base 文件夹下包含 app跳转、沙盒使用、AppCollectionViewLayout、Viewcontrolle、NavigationController、TabbarController 基础封装

O2_Core 属性包裹器、Debug、Random

O3_Foundation Foundation框架的常用扩展

O4_UI UIKit框架的常用扩展

O5_Vendor 强大的CPCollectionViewKit、震动反馈、Snapkit、Toast

O6_Resource 资源文件

欢迎使用，喜欢请star✨




