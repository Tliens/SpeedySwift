//
//  Datapublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 07/12/2016.
//  Copyright © 2016 SpeedySwift
//


import Foundation
// MARK: - Methods
public extension Data {
    /// 转 string
    func toString(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    func toBytes()->[UInt8]{
        return [UInt8](self)
    }
    /// 从给定的JSON数据返回一个基础对象。
    func toModel<T>(_ type:T.Type) -> T? where T:Decodable {
        do {
            return try JSONDecoder().decode(type, from: self)
        } catch  {
            SS.log(false,items: "data to model error")
            return nil
        }
    }
}

