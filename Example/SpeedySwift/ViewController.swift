//
//  ViewController.swift
//  SpeedySwift
//
//  Created by tliens on 03/15/2021.
//  Copyright (c) 2021 tliens. All rights reserved.
//

import UIKit
import SpeedySwift


class Member:Codable {
    @SSCBD<Bool.defalut> var isOk:Bool
    @SSCBD<String.defalut> var name:String
    @SSCBD<Int.defalut> var age:Int
}

class ViewController: SSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bt = UIButton()
        
        bt.image = UIImage(named: "")
        
        let tb = UITableView()
        tb.cell(by: UIView())
        tb.indexPath(by: UIView())
        
        let x:CGFloat = 3.scale
        x.ss_abs
        
//        SSSandbox.shared.homeDirectory
//        SS.cachePath
//        SSJumpAppType.phone
//        SSJumpStatus.init(rawValue: <#T##String#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func showFakeNavBar() {
         
    }
}

class FullViewController:SSFullViewController{
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenStateBar()
        showStateBar()
    }
    
}
class OverFullViewController:SSOverFullViewController{
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MyTabbar:SSTabBarController{
    override func selectedTab(at index: Int, isDouble: Bool) {
        
    }
}
class MyController:SSController{
    override init(view: UIView) {
        super.init(view: view)
    }
    
}
class MyNavigationBar:SSNavigationBar{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


