//
//  BidirectionalCollectionpublic extensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2018/10/13.
//  Copyright © 2018 SpeedySwift
//

// MARK: - Methods
public extension BidirectionalCollection {

    /// 返回指定位置的元素。如果偏移量为负，则返回末端的' n '元素，其中' n '是' abs(distance) '的结果.
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[offset: 1] -> 2
    ///        arr[offset: -2] -> 4
    ///
    /// - Parameter distance: The distance to offset.
    subscript(offset distance: Int) -> Element {
        let index = distance >= 0 ? startIndex : endIndex
        return self[indices.index(index, offsetBy: distance)]
    }

}
