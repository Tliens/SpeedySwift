//
//  SSCollectionViewLayout.swift
//  SpeedySwift
//
//  Created by Bear on 2020/11/13.
//

import UIKit
/// 此 layout 自动根据 direction 分配LineSpacing、InteritemSpacing
open class SSCollectionViewLayout: UICollectionViewFlowLayout {
    /// longitude 竖向间隔  latitude横向间隔
    public init(longitude:CGFloat = 4,
         latitude:CGFloat = 4,
         itemSize:CGSize? = nil,
         sectionInset:UIEdgeInsets = .zero,
         direction:UICollectionView.ScrollDirection = .vertical) {
        
        super.init()
        scrollDirection = direction
        if direction == .horizontal{
            minimumLineSpacing = longitude
            minimumInteritemSpacing = latitude
        }else{
            minimumLineSpacing = latitude
            minimumInteritemSpacing = longitude
        }
        if let _itemSize = itemSize{
            self.itemSize = _itemSize
        }
        self.sectionInset = sectionInset
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
