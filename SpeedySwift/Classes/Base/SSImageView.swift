//
//  SSImageView.swift
//  SpeedySwift
//
//  Created by 2020 on 2021/9/30.
//

import Foundation
open class SSImageView: UIImageView {
    public var url:String = ""{
        didSet{
            SS.cacheImg(url: url) { data in
                if let _data = data{
                    self.image = UIImage(data: _data)
                }
            }
        }
    }
}
