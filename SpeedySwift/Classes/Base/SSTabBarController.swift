//
//  SSTabBarController.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit

open class SSTabBarController: UITabBarController {
    
    open var lastTabBarTime:[Int:TimeInterval] = [:]
    
    var backgroundImgView = UIImageView()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    open func initialize(color:String,radius:CGFloat) {
        self.tabBar.backgroundImage = UIImage()
        let backgroundImgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SS.shared.w, height: SS.shared.safeBottomHeight + 49))
        backgroundImgView.image = UIImage.init(color: UIColor.hex(color))
        self.backgroundImgView = backgroundImgView
        backgroundImgView.topCornerRadius(rect: backgroundImgView.frame, radius: radius)
        self.tabBar.shadow()
        self.tabBar.addSubview(backgroundImgView)
    }
    open func changeTabbarColor(color:String){
        backgroundImgView.image = UIImage.init(color: UIColor.hex(color))
    }
    //去掉顶部黑线
    open func deleteBlackLine(){
        tabBar.barStyle = .black
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
    // 添加子vc
    open func addChildViewController(_ childController: UIViewController,
                                       title: String,
                                       imageName: String,
                                       selectedImageName:String,
                                       index:Int,
                                       normal:UIColor,
                                       selected:UIColor) {
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
        // iOS13以上系统
        self.tabBar.tintColor = selected
        self.tabBar.unselectedItemTintColor = normal
        
        let nav = SSNavigationController(rootViewController: childController)
        addChild(nav)
    }
    /// 点击tabbar
    open func selectedTab(at index: Int,isDouble:Bool) {
        
    }
    
}


extension SSTabBarController: UITabBarControllerDelegate {
    open func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        var isDouble: Bool = false
        let now = Date().timeIntervalSince1970
        if let last = lastTabBarTime[viewController.tabBarItem.tag],(now - last < 0.5) {
            isDouble = true
        }
        lastTabBarTime[viewController.tabBarItem.tag] = now
        self.selectedTab(at: viewController.tabBarItem.tag, isDouble: isDouble)
    }
}
