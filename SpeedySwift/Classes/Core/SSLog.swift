//
//  SSLog.swift
//  SpeedySwift
//
//  Created by Quinn on 2020/11/14.
//

import Foundation
public extension SS{
    /// 只能log到控制台
    static func debug(_ items: Any...,
                      separator: String = " ",
                      terminator: String = "\n",
                      file: String = #file,
                      line: Int = #line,
                      method: String = #function){
        log(false,
            items: items,
            separator:separator,
            terminator:terminator,
            file:file,
            line:line,
            method:method)
    }
    /// log到控制台、沙盒，toFile用于可选是否log到沙盒
    static func log(_ toFile:Bool,
               items: Any...,
               separator: String = " ",
               terminator: String = "\n",
               file: String = #file,
               line: Int = #line,
               method: String = #function){
        if !toFile{
            if !SS.shared.openLog{
                return
            }
        }
        
        let wherefrom = "\((file as NSString).lastPathComponent)[\(line)] + \(method):" + " "
        var logstr = "SS🐻" + separator + date() + separator + (toFile ? "控制台+沙盒":"控制台") + separator + wherefrom
        if SS.shared.openLog{
            print(logstr)
        }
        var i = 0
        let j = items.count
        for a in items {
            i += 1
            logstr += "\(a)" + " "
            if SS.shared.openLog{
                print(" ",a, terminator:i == j ? terminator: separator)
            }
        }
        
        if toFile{
            let logPath = NSHomeDirectory() + "/Documents/Log/"
            checkDir(path: logPath)
            let logFilePath = logPath + "log.txt"
            let logErrorFilePath = logPath + "log_error.txt"
            
            func log_error(){
                let array = [logstr] as NSArray
                if let old = NSArray.init(contentsOfFile: logErrorFilePath){
                    let new = old.adding(logstr) as NSArray
                    let _ = new.write(toFile: logErrorFilePath,atomically : true)
                }else{
                    let _ = array.write(toFile: logErrorFilePath,atomically : true)
                }
            }
            
            if let fp = fopen(logFilePath, "a"){
                let ret = fputs(("\n"+logstr).cString(using: String.Encoding.utf8), fp)
                if ret == -1{
                    /// 写入失败则用其他方式写入
                    log_error()
                }
                fclose(fp)
            }
        }
    }
    private static func checkDir(path:String){
        var isDir: ObjCBool = true
        let isExists = FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
        if !isExists {
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
    private static func date()->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY.MM.dd HH:mm:ss"
        dateformatter.locale = .current
        return dateformatter.string(from: Date())
    }
}
