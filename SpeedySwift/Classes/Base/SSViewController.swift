//
//  AppViewController.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import Foundation
import UIKit


open class SSViewController: UIViewController{
    
    open var fakeNav:SSNavigationBar = SSNavigationBar()
    
    deinit {
        // 移除通知监听者
        removeNotifacationObserver()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        if #available(iOS 11.0, *) {
            extendedLayoutIncludesOpaqueBars = true
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    // 状态栏
    open override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK: - 导航条上左右按钮的点击时间
    open func handleNavigationBarButton(buttonType : UINavigationBarButtonType) {
        if buttonType == .left {
            self.back()
        }
    }
    open func removeNotifacationObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    open func hideNavBar(){
        self.navigationController?.isNavigationBarHidden = true
    }
    open func showNavBar(){
        self.hideFakeNavBar()
        self.navigationController?.isNavigationBarHidden = false
    }
    open func showFakeNavBar(){
        self.hideNavBar()
        self.fakeNav.isHidden = false
        view.addSubview(fakeNav)
        fakeNav.snp.makeConstraints({ (maker) in
            maker.left.right.top.equalToSuperview()
            maker.height.equalTo(SS.statusWithNavBarHeight)
        })
    }
    open func hideFakeNavBar(){
        self.fakeNav.isHidden = true
    }
    
    open func blackStateBar(){
        UIApplication.shared.statusBarStyle = .default
    }
    open func whiteStateBar(){
        UIApplication.shared.statusBarStyle = .lightContent
    }
    open func hiddenStateBar(){
        UIApplication.shared.isStatusBarHidden = true
    }
    open func showStateBar(){
        UIApplication.shared.isStatusBarHidden = false
    }

}

// 通知相关
extension SSViewController {
    
    
    /// 添加公共通知，默认没调用
    open func addPublicNotification() {
        // app进入前台
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        // app进入后台
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterBackGround),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
    }
    
    //MARK: - 以下通知方法只在调用 ‘addPublicNotification()’方法后生效
    /// 进入前台
    @objc open func didBecomeActive() {
        // should overwrite
        
    }
    
    /// 进入后台
    @objc open func didEnterBackGround() {
        // should overwrite
        
    }
}
