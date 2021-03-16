//
//  AppViewController.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import Foundation
import UIKit

open class SSFullViewController: SSViewController{
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overFullScreen
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        modalPresentationStyle = .overFullScreen
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
}
open class SSViewController: UIViewController{
    
    public var fakeNav:SSNavigationBar = SSNavigationBar()
    
    deinit {
        // 移除通知监听者
        removeNotifacationObserver()
    }
    
    public override func viewDidLoad() {
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
    public override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK: - 导航条上左右按钮的点击时间
    public func handleNavigationBarButton(buttonType : UINavigationBarButtonType) {
        if buttonType == .left {
            self.back()
        }
    }
    public func removeNotifacationObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    public func hideNavBar(){
        self.navigationController?.isNavigationBarHidden = true
    }
    public func showNavBar(){
        self.hideFakeNavBar()
        self.navigationController?.isNavigationBarHidden = false
    }
    public func showFakeNavBar(){
        self.hideNavBar()
        self.fakeNav.isHidden = false
        view.addSubview(fakeNav)
        fakeNav.snp.makeConstraints({ (maker) in
            maker.left.right.top.equalToSuperview()
            maker.height.equalTo(SS.statusWithNavBarHeight)
        })
    }
    public func hideFakeNavBar(){
        self.fakeNav.isHidden = true
    }
    
    public func blackStateBar(){
        UIApplication.shared.statusBarStyle = .default
    }
    public func whiteStateBar(){
        UIApplication.shared.statusBarStyle = .lightContent
    }
    public func hiddenStateBar(){
        UIApplication.shared.isStatusBarHidden = true
    }
    public func showStateBar(){
        UIApplication.shared.isStatusBarHidden = false
    }

}

// 通知相关
extension SSViewController {
    
    
    /// 添加公共通知，默认没调用
    public func addPublicNotification() {
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
    @objc public func didBecomeActive() {
        // should overwrite
        
    }
    
    /// 进入后台
    @objc public func didEnterBackGround() {
        // should overwrite
        
    }
}
