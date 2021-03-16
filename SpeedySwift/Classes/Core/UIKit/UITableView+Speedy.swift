//
//  UITableView+Speedy.swift
//  SpeedySwift
//
//  Created by Quinn on 2021/1/8.
//

import UIKit

extension UITableView{
    func indexPath(by child:UIView)->IndexPath?{
        let point = child.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: point)
    }
    func cell(by child:UIView)->UITableViewCell?{
        let point = child.convert(CGPoint.zero, to: self)
        if let indexPath = self.indexPathForRow(at: point){
            return self.cellForRow(at: indexPath)
        }
        return nil
    }
}
