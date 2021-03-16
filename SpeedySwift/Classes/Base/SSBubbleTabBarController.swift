//
//  AppBubbleTabBarController.swift
//  SpeedySwift
//
//  Created by 2020 on 2020/11/25.
//

import UIKit

open class SSBubbleTabBarController: SSTabBarController {

    public var my_tabBar : SSBubbleTabBar!

    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public func setTabbar(_ tabbar:SSBubbleTabBar){
        my_tabBar = tabbar
        tabbar.onSelect = {[weak self] index in
            self?.centerBtnAction()
        }
        self.setValue(tabbar, forKeyPath: "tabBar")
    }
    
    private func centerBtnAction() {
        selectedTab(at: my_tabBar.centerBtnTag, isDouble: false)
    }


}
