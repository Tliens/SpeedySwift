//
//  SpeedySwift+Cache.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//
// MARK: 缓存
import UIKit

extension SpeedySwift{
    /// 缓存路径
    var cachePath:String {
        return SpeedySandbox.shared.cachesDirectory + "/" + "SpeedyCache"
    }
    /**
     获取缓存的对象(同步)
     - parameter URL: 数据请求URL
     - parameter subPath:      二级文件夹路径subPath（可设置-可不设置）
     - returns: 缓存对象
     */
    public func getCacheJsonWithURL(_ URL: String, subPath:String = "") -> AnyObject? {
        
        lock.wait()
        var resultObject: AnyObject?
        let path = getCacheFilePath(url: URL, subPath: subPath)
        let fileManager: FileManager = FileManager.default
        if fileManager.fileExists(atPath: path, isDirectory: nil) == true {
            let data: Data = fileManager.contents(atPath: path)!
            resultObject = try? data.jsonObject() as AnyObject
        }
        lock.signal()
        return resultObject
    }
    
    // MARK: - 私有方法
    // 获取缓存文件路径
    fileprivate func getCacheFilePath(url: String, subPath:String?) -> String {
        var newPath: String = self.cachePath
        
        if let tempSubPath = subPath, tempSubPath.count > 0 {
            newPath = self.cachePath + "/" + tempSubPath
        }
        
        self.checkDirectory(newPath)
        //check路径
        let cacheFileNameString: String = "URL:\(url) AppVersion:\(SS.appVersion ?? "")"
        let cacheFileName: String = cacheFileNameString.md5
        newPath = newPath + "/" + cacheFileName
        return newPath
    }
    /// 检查文件夹
    fileprivate func checkDirectory(_ path: String) {
        let fileManager: FileManager = FileManager.default
        
        var isDir = ObjCBool(false) //isDir判断是否为文件夹
        if !fileManager.fileExists(atPath: path, isDirectory: &isDir) {
            SS.createBaseDirectoryAtPath(path)
        } else {
            if !isDir.boolValue {
                do {
                    try fileManager.removeItem(atPath: path)
                    SS.createBaseDirectoryAtPath(path)
                } catch let error as NSError {
                    SS.log("创建缓存文件夹失败，error - [\(error)]")
                }
            }
        }
    }
    // MARK: - 创建文件夹
    public static func createBaseDirectoryAtPath(_ path: String) {
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            self.addDoNotBackupAttribute(path)
        }
        catch let error as NSError {
            SS.log("[缓存调试]-创建缓存文件夹失败！error[\(error)]")
        }
    }
    // 设置不备份
    public static func addDoNotBackupAttribute(_ path: String) {
        let url: URL = URL(fileURLWithPath: path)
        do {
            try  (url as NSURL).setResourceValue(NSNumber(value: true as Bool), forKey: URLResourceKey.isExcludedFromBackupKey)
        }
        catch let error as NSError {
            SS.log("[缓存调试] - 设置不备份属性失败,error[\(error)]")
        }
    }
}
