//
//  UIButton+Speedy.swift
//  WorldClock
//
//  Created by 2020 on 2020/10/20.
//

import UIKit
extension UIButton {
    
    var btnImage : UIImage? {
        set {
            self.setImage(newValue, for: .normal)
            self.setImage(newValue, for: .selected)
            self.setImage(newValue, for: .highlighted)
        }
        
        get {
            return self.image(for: .normal)!
        }
    }
    
    var btnBackgroundImage : UIImage? {
        set {
            self.setBackgroundImage(newValue, for: .normal)
            self.setBackgroundImage(newValue, for: .selected)
            self.setBackgroundImage(newValue, for: .highlighted)
        }
        
        get {
            return self.backgroundImage(for: .normal)!
        }
    }
    
    var btnTitle : String? {
        set {
            self.setTitle(newValue, for: .normal)
            self.setTitle(newValue, for: .selected)
            self.setTitle(newValue, for: .highlighted)
        }
        
        get {
            return self.title(for: .normal) ?? ""
        }
    }
    
    var btnTitleColor : UIColor? {
        set {
            self.setTitleColor(newValue, for: .normal)
            self.setTitleColor(newValue, for: .selected)
            self.setTitleColor(newValue, for: .highlighted)
        }
        
        get {
            return self.titleColor(for: .normal)!
        }
    }
    
    var btnTitleFont : UIFont? {
        set {
            self.titleLabel?.font = newValue
        }
        
        get {
            return self.titleLabel!.font
        }
    }
    
    
}
extension UIButton{
    convenience init(title: String?, titleColor: UIColor?, titleFont: UIFont?, backgroundColor: UIColor = UIColor.clear, cornerRadius: CGFloat = 0) {
        self.init()
        self.btnTitle = title
        self.btnTitleColor = titleColor
        self.btnTitleFont = titleFont
        self.backgroundColor = backgroundColor
        if cornerRadius > 0 {
            self.cornerRadius = cornerRadius
        }
    }
    
    convenience init(imageName: String) {
        self.init()
        self.btnImage = UIImage(named: imageName)
    }
    
    convenience init(normalImageName: String, selectImageName: String) {
        self.init()
        self.setImage(UIImage(named: normalImageName), for: .normal)
        self.setImage(UIImage(named: selectImageName), for: .selected)
        self.setImage(UIImage(named: selectImageName), for: .highlighted)
    }
}
