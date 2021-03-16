//
//  SSBubbleTabBar.swift
//  SpeedySwift
//
//  Created by 2020 on 2020/11/25.
//

import UIKit
/// 默认两个tab，一个凸起
open class SSBubbleTabBar: UITabBar {
    
    open var onSelect: ((Int) -> ())?
    open var bgImageName:String!
    open var centerBtnImageName:String!
    open var centerBtnTag = 0

    private var centerBtn:UIButton?
    private var bgImageView = UIImageView()
    private var buttonImage:UIImage?{
        didSet{
            centerBtn?.image = buttonImage
        }
    }
    private var centerBtnHeight: CGFloat = 59.0
    private var centerBtnOffSetY: CGFloat = 28
    public init(frame: CGRect,
                bgImageName: String,
                centerBtnImageName:String,
                centerBtnHeight:CGFloat,
                centerBtnOffSetY:CGFloat) {
        super.init(frame: frame)
        self.bgImageName = bgImageName
        self.centerBtnImageName = centerBtnImageName
        self.centerBtnHeight = centerBtnHeight
        self.centerBtnOffSetY = centerBtnOffSetY
        buildUI()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildUI() {
        // 去掉系统tabBar的顶部细线
        barStyle = .black
        backgroundImage = UIImage()
        shadowImage = UIImage()
        // 背景
        var my_size:CGSize = .zero
        if !SS.isX{
            my_size = CGSize(width: SS.w, height: SS.safeBottomHeight + 60)
        }else{
            my_size = CGSize(width: SS.w, height: SS.safeBottomHeight + 49)
        }
        bgImageView = UIImageView(frame: CGRect(origin: .zero, size: my_size))
        bgImageView.image = UIImage(color: .yellow)
        bgImageView.backgroundColor = .clear
        bgImageView.topCornerRadius(rect: bgImageView.bounds, radius: 12.scale)
        addSubview(bgImageView)
        // 中间按钮
        let button_w: CGFloat = SS.w/3
        let button = UIButton(frame: CGRect(x: button_w, y: -centerBtnOffSetY, width: button_w, height: centerBtnHeight))
        centerBtn = button
        buttonImage = UIImage(named: centerBtnImageName)
        button.tag = 1
        button.addTarget(self, action: #selector(tabBarButtonClicked(sender:)), for: .touchUpInside)
        self.addSubview(button)
        
    }
    
    @objc private func tabBarButtonClicked(sender: UIButton) {
        if let handler = self.onSelect {
            handler(sender.tag)
        }
    }
    //处理超出区域点击无效的问题
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isHidden{
            //转换坐标
            if let tempPoint = centerBtn?.convert(point, from: self){
                //判断点击的点是否在按钮区域内
                if centerBtn?.bounds.contains(tempPoint) ?? false{
                    // 返回按钮
                    return centerBtn
                }
            }
        }
        return super.hitTest(point, with: event)
    }
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        if !SS.isX{
            return CGSize(width: SS.w, height: SS.safeBottomHeight + 60)
        }else{
            return CGSize(width: SS.w, height: SS.safeBottomHeight + 49)
        }
        
    }
}
