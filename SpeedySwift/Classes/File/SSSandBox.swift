//
//  SpeedySandBox.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//
// MARK: 沙盒
import UIKit
@objcMembers
open class SSSandbox: NSObject {
    
    public static let shared = SSSandbox()
    
    /// 禁止外部调用init初始化方法
    private override init(){
        super.init()
        
    }
    /// 检查是否存在路径
    public func checkDir(path:String){
        var isDir: ObjCBool = true
        let isExists = FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
        if !isExists {
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
    /// 获取程序的Home目录
    public var homeDirectory: String {
        let path = NSHomeDirectory()
        return path
    }
    
    /// Documents 目录：您应该将所有的应用程序数据文件写入到这个目录下。这个目录用于存储用户数据。该路径可通过配置实现iTunes共享文件。可被iTunes备份。
    public var documentDirectory: String {
        
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return ""
        }
        return path
    }
    
    /// 获取Library目录
    /*
     * Library 目录：这个目录下有两个子目录：
     * Preferences 目录：包含应用程序的偏好设置文件。您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.
     * Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。
     * 可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份。
     */
    public var libraryDirectory: String {
        guard let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first else {
            return ""
        }
        return path
    }
    
    /// Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。
    public var cachesDirectory: String {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            return ""
        }
        return path
    }
    
    /// tmp目录：这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息。该路径下的文件不会被iTunes备份。
    public var tmpDirectory: String {
        
        let path = NSTemporaryDirectory()
        return path
    }
    
    /// 检查文件是否存在
    public static func checkPathExists(_ path: String) ->Bool{
        let fileManager: FileManager = FileManager.default
        return fileManager.fileExists(atPath: path)
    }
    
    /// 缓存路径
    public static var cachePath:String {
        return SSSandbox.shared.cachesDirectory + "/" + "SSCache"
    }
    /// 图片缓存路径
    public static var cacheImgPath:String {
        return SSSandbox.shared.cachesDirectory + "/" + "SSCache" + "/" + "Img/"
    }
    /// API缓存路径
    public static var cacheAPIPath:String {
        return SSSandbox.shared.cachesDirectory + "/" + "SSCache" + "/" + "API/"
    }
}

