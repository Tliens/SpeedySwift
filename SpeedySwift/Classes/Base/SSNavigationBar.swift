//
//  SSNavigationBar.swift
//  SSSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
import SnapKit
open class SSNavigationBar: UIView {
    open var leftButton = UIButton()
    open var titleLabel = UILabel(text: "", textColor: .hex("#222222"), textFont: .sc_medium(size: 18),textAlignment:.center)
    open var rightButton = UIButton()
    
    open var leftButtonHandler : (() -> ())?
    open var rightButtonHandler : (() -> ())?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        buildUI()
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        buildLeftBtn()
        buildTitleLabel()
        buildRightButton()
    }
    private func buildLeftBtn(){
        self.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        leftButton.snp.makeConstraints({ (make) in
            make.left.equalTo(4)
            make.bottom.equalTo(-2)
            make.width.height.equalTo(40)
        })
    }
    private func buildTitleLabel(){
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(44)
            make.right.equalTo(-44)
            make.height.equalTo(22.0)
            make.bottom.equalTo(-11.0)
        })
    }
    private func buildRightButton(){
        rightButton = UIButton(title: "", titleColor: UIColor.black, titleFont: UIFont.systemFont(ofSize: 16))
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        self.addSubview(rightButton)
        rightButton.isHidden = true
        
        rightButton.snp.makeConstraints({ (make) in
            make.right.equalTo(-10)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(44)
        })
    }
    @objc private func leftButtonAction() {
        if let handler = self.leftButtonHandler {
            handler()
        }
    }
    
    @objc private func rightButtonAction() {
        if let handler = self.rightButtonHandler {
            handler()
        }
    }
}
