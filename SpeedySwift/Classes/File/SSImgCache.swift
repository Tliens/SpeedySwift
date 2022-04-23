//
//  SSImgCache.swift
//  SpeedySwift
//
//  Created by 2020 on 2021/9/30.
//

import Foundation

public extension SS{
    /// 缓存图片
    static func cacheImg(url:String,callback:@escaping((_ data:Data?)->Void)){
        let name = url.md5
        let path = SSSandbox.cacheImgPath + name
        
        if let localURL = path.localURL{
            if !SSSandbox.checPathExists(path){
                DispatchQueue.global().async {
                    if let netURL = url.netUrl{
                        if let data = try? Data(contentsOf: netURL){
                            DispatchQueue.main.async {
                                try? data.write(to: localURL)
                                callback(data)
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            callback(nil)
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                    if let data = try? Data(contentsOf: localURL){
                        callback(data)
                    }else{
                        callback(nil)
                    }
                }
            }
        }else{
            callback(nil)
        }
    }
}
