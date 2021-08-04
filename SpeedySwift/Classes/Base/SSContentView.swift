//
//  SSContentView.swift
//  SpeedySwift
//
//  Created by Quinn on 2021/5/31.
//

import UIKit
/// 不响应事件视图
open class SSContentView: UIView {

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event);
        if (view == self) {
            return nil
        }
        return view
    }

}
