//
//  SSFullViewController.swift
//  SpeedySwift
//
//  Created by 2020 on 2021/3/16.
//

import UIKit

/// 全屏显示
open class SSFullViewController: SSViewController{
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .fullScreen
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        modalPresentationStyle = .fullScreen
    }
}
/// 在当前界面上之上显示，当前ViewController依旧存在，注意生命周期
open class SSOverFullViewController: SSViewController{
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overFullScreen
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        modalPresentationStyle = .overFullScreen
    }
   
}
