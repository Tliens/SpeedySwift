//
//  UITableView+Speedy.swift
//  SpeedySwift
//
//  Created by Quinn on 2021/1/8.
//

import UIKit

public extension UITableView{
    /// 根据View 获取对应Cell的indexpath
    func indexPath(by child:UIView)->IndexPath?{
        let point = child.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: point)
    }
    /// 根据 child view  获取对应Cell
    func cell(by child:UIView)->UITableViewCell?{
        let point = child.convert(CGPoint.zero, to: self)
        if let indexPath = self.indexPathForRow(at: point){
            return self.cellForRow(at: indexPath)
        }
        return nil
    }
}

public extension UICollectionView{
    /// 根据View 获取对应Cell的indexpath
    func indexPath(by child:UIView)->IndexPath?{
        let point = child.convert(CGPoint.zero, to: self)
        return self.indexPathForItem(at: point)
    }
    /// 根据 child view  获取对应Cell
    func cell(by child:UIView)->UICollectionViewCell?{
        let point = child.convert(CGPoint.zero, to: self)
        if let indexPath = self.indexPathForItem(at: point){
            return self.cellForItem(at: indexPath)
        }
        return nil
    }
}
