//
//  SSImageWithoutRender.swift
//  SpeedySwift
//
//  Created by 2020 on 2022/3/5.
//

import Foundation
/// 设置tableview 侧滑按钮图片
open class SSImageWithoutRender:UIImage{
    open override func withRenderingMode(_ renderingMode: UIImage.RenderingMode) -> UIImage {
        return self
    }
}
