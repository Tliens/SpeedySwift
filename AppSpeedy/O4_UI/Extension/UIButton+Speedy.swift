//
//  UIButton+Speedy.swift
//  AppSpeedy
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
extension UIButton {
    
    public var image : UIImage? {
        set {
            self.setImage(newValue, for: .normal)
        }
        get {
            return self.image(for: .normal)!
        }
    }
    
    public var backgroundImage : UIImage? {
        set {
            self.setBackgroundImage(newValue, for: .normal)
        }
        get {
            return self.backgroundImage(for: .normal)!
        }
    }
    
    public var title : String? {
        set {
            self.setTitle(newValue, for: .normal)
        }
        get {
            return self.title(for: .normal) ?? ""
        }
    }
    
    public var titleColor : UIColor? {
        set {
            self.setTitleColor(newValue, for: .normal)
        }
        get {
            return self.titleColor(for: .normal)!
        }
    }
    
    public var titleFont : UIFont? {
        set {
            self.titleLabel?.font = newValue
        }
        
        get {
            return self.titleLabel!.font
        }
    }
    
    
}
extension UIButton{
    public convenience init(title: String?, titleColor: UIColor?, titleFont: UIFont?, backgroundColor: UIColor = UIColor.clear, cornerRadius: CGFloat = 0) {
        self.init()
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.backgroundColor = backgroundColor
        if cornerRadius > 0 {
            self.cornerRadius = cornerRadius
        }
    }
    
    public convenience init(imageName: String) {
        self.init()
        self.image = UIImage(named: imageName)
    }
    
    public convenience init(normalImageName: String, selectImageName: String) {
        self.init()
        self.setImage(UIImage(named: normalImageName), for: .normal)
        self.setImage(UIImage(named: selectImageName), for: .selected)
        self.setImage(UIImage(named: selectImageName), for: .highlighted)
    }
}
