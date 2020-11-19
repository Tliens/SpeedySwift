//
//  CollectionViewTimeMachineLayout.swift
//  CPCollectionViewKit
//
//  Created by Parsifal on 2017/2/13.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import Foundation
import UIKit

open class TimeMachineLayoutConfiguration: LayoutConfiguration {
    
    public var visibleCount = 0
    public var minCellSize = CGSize(width: 50, height: 50)
    public var scaleFactor: CGFloat = 0.5//(0, 1)
    public var spacingX: CGFloat = 20
    public var spacingY: CGFloat = 0
    override public var spacing: CGFloat {
        didSet {
            spacingX = spacing
            spacingY = spacing
        }
    }
    
    public var reversed: Bool = false
    
}

open class CollectionViewTimeMachineLayout: CollectionViewLayout {
    
    public var configuration: TimeMachineLayoutConfiguration
    
    public init(withConfiguration configuration: TimeMachineLayoutConfiguration) {
        self.configuration = configuration
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.configuration =  TimeMachineLayoutConfiguration(withCellSize: CGSize(width: 100, height: 100))
        super.init(coder: aDecoder)
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { return super.layoutAttributesForItem(at: indexPath)}
        
        let attributes = attributesForCollectionView(collectionView: collectionView, indexPath: indexPath)
        return attributes
    }
 
    open override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return super.collectionViewContentSize }
        
        var contentSize = CGSize(width: CGFloat(), height: CGFloat())
        let cellHeight = configuration.cellSize.height
        let height = CGFloat(cellCount - 1) * cellHeight + collectionView.bounds.height
        contentSize.width = collectionView.bounds.width
        contentSize.height = height
        
        return contentSize
    }
    
    func calculateTopItemIndex() -> CGFloat {
        guard let collectionView = collectionView else { return 0 }
        
        var topItemIndex: CGFloat

        if configuration.reversed {
            topItemIndex = CGFloat(cellCount - 1) - collectionView.contentOffset.y / configuration.cellSize.height
        } else {
            topItemIndex = collectionView.contentOffset.y / configuration.cellSize.height
        }
        
        return topItemIndex
    }
}

extension CollectionViewTimeMachineLayout: CollectionViewLayoutProtocol {
    
    public var currentIndex: Int {
        let topItemIndex = calculateTopItemIndex()
        var currentIndex = Int(round(topItemIndex))
        
        if cellCount > 0 {
            currentIndex = min(cellCount-1, currentIndex)
        } else {
            currentIndex = 0
        }
        
        currentIndex = max(0, currentIndex)
        
        return currentIndex
    }
    
    public func contentOffsetFor(indexPath: IndexPath) -> CGPoint {
        var contenOffset = CGPoint.zero
        contenOffset.y = CGFloat(indexPath.item) * configuration.cellSize.height
        return contenOffset
    }
    
    public func attributesForCollectionView(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath) else {
            return nil
        }
        
        let item = CGFloat(indexPath.item)
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        let cellSize = configuration.cellSize
        let visibleCount = configuration.visibleCount <= 0 ? CGFloat(cellCount) : CGFloat(min(configuration.visibleCount, cellCount))
        var centerX: CGFloat = 0.0
        var centerY: CGFloat = 0.0
        
        //update attributes
        let topItemIndex = calculateTopItemIndex()
        var itemOffset: CGFloat
        
        if configuration.reversed {
            itemOffset = topItemIndex - item
            attributes.zIndex = indexPath.item
        } else {
            itemOffset =  item - topItemIndex
            attributes.zIndex = -indexPath.item
        }
        
        attributes.size = cellSize
        
        var transform = CGAffineTransform.identity
        
        if itemOffset < visibleCount + 1 && itemOffset >= -1 {
            centerX = width / 2 + itemOffset * configuration.spacingX
            centerY = height / 2 + collectionView.contentOffset.y + itemOffset * configuration.spacingY
            
            let scaleFactor = 1 - itemOffset / CGFloat(visibleCount) * configuration.scaleFactor
            let scaleTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            transform = scaleTransform
            
            attributes.isHidden = false
            attributes.alpha = itemOffset + 1
        } else {
            centerX = -width / 2
            centerY = -height / 2
            
            attributes.isHidden = true
        }
        
        attributes.center = CGPoint(x: centerX + configuration.offsetX,
                                    y: centerY + configuration.offsetY)
        attributes.transform = transform
        //        print("item:\(item) itemOffset:\(itemOffset)")
        return attributes
    }
    
}

