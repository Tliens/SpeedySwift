//
//  AppBubbleTabBarController.swift
//  App1125
//
//  Created by 2020 on 2020/11/25.
//

import UIKit

public class AppBubbleTabBarController: AppTabBarController {

    var my_tabBar : AppBubbleTabBar!

    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setTabbar(_ tabbar:AppBubbleTabBar){
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
