//
//  AppTabBarController.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit

public class AppTabBarController: UITabBarController {
    
    var lastTabBarTime:[Int:TimeInterval] = [:]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    public func initialize() {
        self.tabBar.backgroundImage = UIImage()
        let backgroundImgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: App.w, height: App.safeBottomHeight + 49))
        backgroundImgView.image = UIImage.init(color: UIColor.white)
        self.tabBar.addSubview(backgroundImgView)
        self.tabBar.tintColor = UIColor.hex("#FF7B86")
    }
    //去掉顶部黑线
    public func deleteBlackLine(){
        tabBar.barStyle = .black
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
    // 添加子vc
    public func addChildViewController(_ childController: UIViewController, title: String, imageName: String,selectedImageName:String,index:Int,normal:UIColor = .hex("#888888", alpha: 0.24),selected:UIColor = .hex("#222222", alpha: 1)) {
        childController.title = title
        childController.closePopGestureRecognizer = true
        if imageName.count > 0{
            childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
            childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
            childController.tabBarItem.title = title
            childController.tabBarItem.tag = index
            childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:normal], for: .normal)
            childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:selected], for: .selected)
        }
        let nav = AppNavigationController(rootViewController: childController)
        addChild(nav)
    }
    
    public func selectedTab(at index: Int,isDouble:Bool) {
        
    }
    
}


extension AppTabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        var isDouble: Bool = false
        let now = Date().timeIntervalSince1970
        if let last = lastTabBarTime[viewController.tabBarItem.tag],(now - last < 0.5) {
            isDouble = true
        }
        self.selectedTab(at: viewController.tabBarItem.tag, isDouble: isDouble)
    }
}
