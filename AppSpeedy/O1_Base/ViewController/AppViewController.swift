//
//  AppViewController.swift
//  WorldClock
//
//  Created by 2020 on 2020/10/20.
//

import Foundation
import UIKit

class AppFullViewControllerV: AppViewController{
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overFullScreen
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        modalPresentationStyle = .overFullScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
}
class AppViewController: UIViewController{
    
    var navigationBar:AppNavigationBar?
    
    deinit {
        // 移除通知监听者
        removeNotifacationObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white

    }
    // 状态栏
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK: - 导航条上左右按钮的点击时间
    func handleNavigationBarButton(buttonType : UINavigationBarButtonType) {
        if buttonType == .left {
            self.back()
        }
    }
    func removeNotifacationObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    func hiddenNavBar(){
        self.navigationController?.isNavigationBarHidden = true
    }
    func showNavBar(){
        self.hiddenFakeNavBar()
        self.navigationController?.isNavigationBarHidden = false
    }
    func showFakeNavBar(){
        self.hiddenNavBar()
        self.navigationBar?.isHidden = false
        navigationBar = AppNavigationBar()
        view.addSubview(navigationBar!)
    }
    func hiddenFakeNavBar(){
        self.navigationBar?.isHidden = true
    }
    
    func blackStateBar(){
        UIApplication.shared.statusBarStyle = .default
    }
    func whiteStateBar(){
        UIApplication.shared.statusBarStyle = .lightContent
    }
    func hiddenStateBar(){
        UIApplication.shared.isStatusBarHidden = true
    }
    func showStateBar(){
        UIApplication.shared.isStatusBarHidden = false
    }

}

// 通知相关
extension AppViewController {
    
    
    /// 添加公共通知，默认没调用
    func addPublicNotification() {
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
