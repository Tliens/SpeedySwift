//
//  UIViewController+Speedy.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
public enum UINavigationBarButtonType {
    case left
    case right
}

public var closePopGestureRecognizerKey = "closePopGestureRecognizer"

extension UIViewController {
    
    public var closePopGestureRecognizer: Bool {
        set {
            objc_setAssociatedObject(self, &closePopGestureRecognizerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let rs = objc_getAssociatedObject(self, &closePopGestureRecognizerKey) as? Bool {
                return rs
            }
            return false
        }
    }
    
    public var navBar: UINavigationBar? {
        var bar : UINavigationBar?
        if self.isKind(of: UINavigationController.self) {
            let navController = self as! UINavigationController
            bar = navController.navigationBar
        } else {
            bar = self.navigationController?.navigationBar
        }
        return bar
    }
    
    public var navTitleColor : UIColor? {
        set {
            var attributes = self.navBar?.titleTextAttributes
            if attributes == nil {
                attributes = [NSAttributedString.Key.foregroundColor : newValue!]
            } else {
                attributes![NSAttributedString.Key.foregroundColor] = newValue!
            }
            
            self.navBar?.titleTextAttributes = attributes
        }
        get {
            return nil
        }
    }
    
    public var navTitleFont : UIFont? {
        set {
            var attributes = self.navBar?.titleTextAttributes
            if attributes == nil {
                attributes = [NSAttributedString.Key.font : newValue!]
            } else {
                attributes![NSAttributedString.Key.font] = newValue
            }
            
            self.navBar?.titleTextAttributes = attributes
        }
        
        get {
            return nil
        }
    }
    
}


// MARK: -  处理界面跳转
extension UIViewController {
    
    /// 通过UIStoryboard创建UIViewController
    public class func storyboard<T: UIViewController>(storyboardName: String, classType: T.Type, identifier: String = T.named) -> T? {
        if identifier.count == 0 {
            return nil
        }
        let vc = UIStoryboard(name: storyboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier) as? T
        return vc
    }
    
    /// 前进到下一页面
    public func go(_ viewController: UIViewController, animated: Bool = true) {
        if let nav = self.navigationController {
            nav.pushViewController(viewController, animated: animated)
        } else {
            present(viewController, animated: animated, completion: nil)
        }
    }
    
    /// 返回到下一页面
    public func back(isPopToRoot: Bool? = false, animated: Bool = true) {
        if let nav = self.navigationController {
            if nav.viewControllers.count == 1 && nav.viewControllers.first == self, nav.presentingViewController != nil {
                nav.dismiss(animated: true, completion: nil)
            } else {
                if isPopToRoot == true {
                    nav.popToRootViewController(animated: animated)
                }else {
                    nav.popViewController(animated: animated)
                }
            }
        } else {
            self.dismiss(animated: animated, completion: nil)
        }
    }
    
    /// 返回到指定的页面 special
    public func back(svc: UIViewController.Type) -> Bool {
        var isSuccess = false
        if let nav = self.navigationController {
            for vc in nav.viewControllers {
                if vc.isKind(of: svc) {
                    nav.popToViewController(vc, animated: true)
                    isSuccess = true
                    break
                }
            }
        }
        return isSuccess
    }
    
    // MARK: - 跳转到指定的VC
    public func jump(_ jvc: UIViewController.Type) {
        
        // 就在当前界面
        if self.isKind(of: jvc) {
            return
        }
        
        // 情况1、存在navigationController
        var jumpVC: UIViewController?
        var jumpNav: UINavigationController?
        if let nav = self.navigationController {
            for tempVC in nav.viewControllers {
                if tempVC.isKind(of: jvc) {
                    jumpVC = tempVC
                    jumpNav = nav
                    break
                }
            }
        }
        
        if let finnalVC = jumpVC, let finalNav = jumpNav {
            finalNav.popToViewController(finnalVC, animated: true)
            return
        }
        
        // 情况2、存在tabBarController
        if let tabBarC = self.tabBarController, let nav = tabBarC.navigationController {
            for tempVC in nav.viewControllers {
                if tempVC.isKind(of: jvc) {
                    jumpVC = tempVC
                    jumpNav = nav
                    break
                }
            }
        }
        
        if let finnalVC = jumpVC, let finalNav = jumpNav {
            finalNav.popToViewController(finnalVC, animated: true)
            return
        }
        
        // 情况3、模态跳转出的界面，这种情况比较复杂
        var presentingVC = self
        while presentingVC.presentingViewController != nil {
            presentingVC = presentingVC.presentingViewController!
        }
        presentingVC.dismiss(animated: true, completion: nil)
    }
    
    /// 从导航栈中移除指定类型的VC
    public func navRemove(_ vc: UIViewController.Type) {
        if let nav = self.navigationController {
            let originVCs = nav.viewControllers
            var newVCs:[UIViewController] = []
            for tempVC in originVCs {
                if !tempVC.isKind(of: vc) {
                    newVCs.append(tempVC)
                }
            }
            nav.viewControllers = newVCs
        }
    }
    /// 从导航栈中移除指定类型的[VC]
    public func navRemove(_ vcs: [UIViewController.Type]) {
        if let nav = self.navigationController {
            let originVCs = nav.viewControllers
            var newVCs:[UIViewController] = []
            for tempVC in originVCs {
                var isContain = false
                for classType in vcs {
                    if tempVC.isKind(of: classType) {
                        isContain = true
                        break
                    }
                }
                if isContain == false {
                    newVCs.append(tempVC)
                }
            }
            nav.viewControllers = newVCs
        }
    }
    
}

extension UIViewController{
    /// 显示Sheet
    @discardableResult
    public func showActionSheet(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let allButtons = buttonTitles ?? [String]()
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        let action = UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
        })
        alertController.addAction(action)

        present(alertController, animated: true, completion: nil)
        return alertController
    }
    @discardableResult
    func showAlert(
        title: String?,
        message: String?,
        buttonTitles: [String]? = nil,
        highlightedButtonIndex: Int? = nil,
        completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
}
