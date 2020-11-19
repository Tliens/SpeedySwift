# SpeedySwift
> 这是一个app开发的加速库，我的几款app都是基于这个加速库完成的《今日计划》《今日扫雷》《喝酒游戏》《神盾局》等。尽量保持开发的原汁原味

## 特色：

- 属性包裹器，包含 [喵神 的使用 Property Wrapper 为 Codable 解码设定默认值](https://mp.weixin.qq.com/s/jOyHRS2Wx6MJpuYuENhVgg)
- 属性包裹器，UserDefault的使用
- UI适配终结，UI+Scale.swift
- SwiftSwifter 的常用函数（我去除了很多不常用的东西）
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
