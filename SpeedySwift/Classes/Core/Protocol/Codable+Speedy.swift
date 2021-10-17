//
//  Codable+Speedy.swift
//  Pods-SSJSON2Model
//
//  Created by Quinn on 2021/10/17.
//

import Foundation

public protocol SSCoadble: Codable{
    func toDict()->Dictionary<String, Any>?
    func toData()->Data?
}

public extension SSCoadble{
    
    func toData()->Data?{
        return try? JSONEncoder().encode(self)
    }
    
    func toDict()->Dictionary<String, Any>? {
        if let data = toData(){
            do{
                return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            }catch{
                 debugPrint(error.localizedDescription)
                return nil
            }
        }else{
            debugPrint("model to data error")
            return nil
        }
    }
}
