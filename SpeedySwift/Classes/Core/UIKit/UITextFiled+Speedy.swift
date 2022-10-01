//
//  UITextFiled+Speedy.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2022/9/17.
//

import Foundation
public extension UITextField{
    func addLeftView(width:CGFloat){
        let x = UIView()
        x.backgroundColor = .clear
        x.frame = CGRect(x: 0, y: 0, width: width, height: 1)
        self.leftView = x
        self.leftViewMode = .always
    }
    func addRightView(width:CGFloat){
        let x = UIView()
        x.backgroundColor = .clear
        x.frame = CGRect(x: 0, y: 0, width: width, height: 1)
        self.rightView = x
        self.rightViewMode = .always
    }
}
