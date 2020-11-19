//
//  AppCollectionViewLayout.swift
//  BeerGame
//
//  Created by Quinn on 2020/11/13.
//

import UIKit

class AppCollectionViewLayout: UICollectionViewFlowLayout {
    /// longitude 竖向间隔  latitude横向间隔
    init(longitude:CGFloat,latitude:CGFloat,itemSize:CGSize,sectionInset:UIEdgeInsets,direction:UICollectionView.ScrollDirection) {
        super.init()
        scrollDirection = direction
        if direction == .horizontal{
            minimumLineSpacing = longitude
            minimumInteritemSpacing = latitude
        }else{
            minimumLineSpacing = latitude
            minimumInteritemSpacing = longitude
        }
        self.itemSize = itemSize
        self.sectionInset = sectionInset
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
