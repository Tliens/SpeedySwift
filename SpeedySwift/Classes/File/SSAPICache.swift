//
//  SSAPICache.swift
//  SpeedySwift
//
//  Created by 2020 on 2021/9/30.
//

import Foundation
public extension SS{
    
    /// Set 缓存数据
    static func asyncSetCache(jsonResponse: AnyObject, URL: String, subPath: String?, completed:@escaping (Bool) -> ()) {
        DispatchQueue.global().async{
            let result = self.setCache(jsonResponse, URL: URL, subPath: subPath)
            DispatchQueue.main.async(execute: {
                completed(result)
            })
        }
    }
    
    /// 写入/更新缓存(同步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
    static func setCache(_ jsonResponse: AnyObject, URL: String, subPath: String?) -> Bool {
        lock.wait()
        let data = (jsonResponse as? Dictionary<String, Any>)?.toData()
        let atPath = getCacheFilePath(url: URL, subPath: subPath)
        let isSuccess = FileManager.default.createFile(atPath:atPath, contents: data, attributes: nil)
        lock.signal()
        return isSuccess
    }
    /// Get  获取数据
    static func getCacheJsonWithURL(_ URL: String, subPath:String = "") -> AnyObject? {
        lock.wait()
        var resultObject: AnyObject?
        let path = getCacheFilePath(url: URL, subPath: subPath)
        let fileManager: FileManager = FileManager.default
        if fileManager.fileExists(atPath: path, isDirectory: nil) == true {
            let data: Data = fileManager.contents(atPath: path)!
            resultObject = try? data.toObject() as AnyObject
        }
        lock.signal()
        return resultObject
    }
    
    /// 获取缓存文件路径
    fileprivate static func getCacheFilePath(url: String, subPath:String?) -> String {
        var newPath: String = SSSandbox.cacheAPIPath
        
        if let tempSubPath = subPath, tempSubPath.count > 0 {
            newPath = SSSandbox.cacheAPIPath + tempSubPath
        }
        
        self.checkDirectory(newPath)
        //check路径
        let cacheFileNameString: String = "URL:\(url) AppVersion:\(SS.versionS)"
        let cacheFileName: String = cacheFileNameString.md5
        newPath = newPath + cacheFileName
        return newPath
    }
    /// 检查文件夹
    static func checkDirectory(_ path: String) {
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
                    SS.log(false,items:"创建缓存文件夹失败，error - [\(error)]")
                }
            }
        }
    }
    /// 创建文件夹
    static func createBaseDirectoryAtPath(_ path: String) {
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            self.addDoNotBackupAttribute(path)
        }
        catch let error as NSError {
            SS.log(false,items:"创建文件夹失败！error[\(error)]")
        }
    }
    /// 设置不备份
    static func addDoNotBackupAttribute(_ path: String) {
        let url: URL = URL(fileURLWithPath: path)
        do {
            try  (url as NSURL).setResourceValue(NSNumber(value: true as Bool), forKey: URLResourceKey.isExcludedFromBackupKey)
        }
        catch let error as NSError {
            SS.log(false,items:"设置不备份失败,error[\(error)]")
        }
    }
}
