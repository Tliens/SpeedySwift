//
//  Navigation.swift
//  WorldClock
//
//  Created by 2020 on 2020/10/20.
//

import Foundation
import UIKit
typealias AppViewControllerAnimationBlock = (_ operation: UINavigationController.Operation, _ fromVC: UIViewController, _ toVC: UIViewController) -> UIViewControllerAnimatedTransitioning

class AppNavigationController: UINavigationController {
    
    var animationBlock : AppViewControllerAnimationBlock?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
            self.delegate = self
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) && animated == true {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) && animated == true {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToRootViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) && animated == true {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToViewController(viewController, animated: animated)
    }
    
}

// MARK: - UINavigationControllerDelegate
extension AppNavigationController : UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.isEnabled = viewController.closePopGestureRecognizer ? false : true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if self.animationBlock != nil {
            return self.animationBlock!(operation, fromVC, toVC)
        }
        return nil
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if interactivePopGestureRecognizer?.isEnabled == false{
            return false
        }
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            return self.viewControllers.count > 1
        }
        return true
    }
}
