//
//  SpeedySwift+Cache.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//
// MARK: 缓存
import UIKit

public extension SpeedySwift{
    /// 缓存路径
    var  cachePath:String {
        return SpeedySandbox.shared.cachesDirectory + "/" + "SpeedyCache"
    }
    //MARK: Set 缓存数据
    /**
     写入/更新缓存(异步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
     - parameter jsonResponse: 要写入的数据(JSON)
     - parameter URL:          数据请求URL
     - parameter subPath:      二级文件夹路径subPath（可设置-可不设置）
     - parameter completed:    异步完成回调(主线程回调)
     */
    func asyncSetCache(jsonResponse: AnyObject, URL: String, subPath: String?, completed:@escaping (Bool) -> ()) {
        DispatchQueue.global().async{
            let result = self.setCache(jsonResponse, URL: URL, subPath: subPath)
            DispatchQueue.main.async(execute: {
                completed(result)
            })
        }
    }
    
    /**
     写入/更新缓存(同步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
     - parameter jsonResponse: 要写入的数据(JSON)
     - parameter URL:          数据请求URL
     - parameter subPath:      二级文件夹路径subPath（可设置-可不设置）
     - returns: 是否写入成功
     */
    func setCache(_ jsonResponse: AnyObject, URL: String, subPath: String?) -> Bool {
        lock.wait()
        let data = (jsonResponse as? Dictionary<String, Any>)?.jsonData()
        let atPath = getCacheFilePath(url: URL, subPath: subPath)
        let isSuccess = FileManager.default.createFile(atPath:atPath, contents: data, attributes: nil)
        lock.signal()
        return isSuccess
    }
    //MARK: Get  获取数据
    /**
     获取缓存的对象(同步)
     - parameter URL: 数据请求URL
     - parameter subPath:      二级文件夹路径subPath（可设置-可不设置）
     - returns: 缓存对象
     */
    func getCacheJsonWithURL(_ URL: String, subPath:String = "") -> AnyObject? {
        
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
    ///创建文件夹
    static func createBaseDirectoryAtPath(_ path: String) {
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            self.addDoNotBackupAttribute(path)
        }
        catch let error as NSError {
            SS.log("[缓存调试]-创建缓存文件夹失败！error[\(error)]")
        }
    }
    // 设置不备份
    static func addDoNotBackupAttribute(_ path: String) {
        let url: URL = URL(fileURLWithPath: path)
        do {
            try  (url as NSURL).setResourceValue(NSNumber(value: true as Bool), forKey: URLResourceKey.isExcludedFromBackupKey)
        }
        catch let error as NSError {
            SS.log("[缓存调试] - 设置不备份属性失败,error[\(error)]")
        }
    }
}
