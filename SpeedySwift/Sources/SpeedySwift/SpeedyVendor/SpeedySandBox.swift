//
//  SpeedySandBox.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//
// MARK: 沙盒
import UIKit
class SpeedySandbox: NSObject {
    
    static let shared = SpeedySandbox()
    
    // 禁止外部调用init初始化方法
    private override init(){
        super.init()
    }
    
    // MARK: - 获取程序的Home目录
    var homeDirectory: String {
        let path = NSHomeDirectory()
        return path
    }
    
    // MARK: - 获取document目录
    // Documents 目录：您应该将所有的应用程序数据文件写入到这个目录下。这个目录用于存储用户数据。该路径可通过配置实现iTunes共享文件。可被iTunes备份。
    var documentDirectory: String {
        
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return ""
        }
        return path
    }
    
    // MARK: - 获取Library目录
    /*
     * Library 目录：这个目录下有两个子目录：
     * Preferences 目录：包含应用程序的偏好设置文件。您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.
     * Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。
     * 可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份。
     */
    var libraryDirectory: String {
        guard let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first else {
            return ""
        }
        return path
    }
    
    // MARK: - 获取Cache目录
    // Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。
    var cachesDirectory: String {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            return ""
        }
        return path
    }
    
    // MARK: - 获取Tmp目录
    // tmp 目录：这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息。该路径下的文件不会被iTunes备份。
    var tmpDirectory: String {
        
        let path = NSTemporaryDirectory()
        return path
    }
}
