//
//  CollectionViewCircleLayout.swift
//  CPCollectionViewKit
//
//  Created by Parsifal on 2017/1/20.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

open class CircleLayoutConfiguration:LayoutConfiguration {

}

open class CollectionViewCircleLayout: CollectionViewLayout {
    // MARK: Properties
    public var configuration: CircleLayoutConfiguration

    // MARK: Methods
    public init(withConfiguration configuration: CircleLayoutConfiguration) {
        self.configuration = configuration
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.configuration = CircleLayoutConfiguration(withCellSize: CGSize(width:50, height:50))
        super.init(coder: aDecoder)
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { return super.layoutAttributesForItem(at: indexPath) }
        
        let attributes = attributesForCollectionView(collectionView: collectionView, indexPath: indexPath)
        return attributes
    }
    
    open override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else {
            return nil
        }
        
        if insertIndexPaths.contains(itemIndexPath)
            && updateAnimationStyle == .custom {
            let x = collectionView!.bounds.width/2
            let y = collectionView!.bounds.height+collectionView!.contentOffset.y
            attributes.center = CGPoint(x: x-configuration.offsetX,
                                        y: y-configuration.offsetY)
        }
        
        return attributes
    }
    
    open override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else {
            return nil
        }
        
        if deleteIndexPaths.contains(itemIndexPath)
            && updateAnimationStyle == .custom {
            let x = collectionView!.bounds.width/2
            let y = collectionView!.bounds.height+collectionView!.contentOffset.y
            attributes.center = CGPoint(x: x-configuration.offsetX,
                                        y: y-configuration.offsetY)
            attributes.alpha = 0
            attributes.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }
        
        return attributes
    }
    
    open override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return CGSize.zero }
        
        var contentSize = CGSize(width: CGFloat(), height: CGFloat())
        let bounds = collectionView.bounds.size
        contentSize.width = bounds.width
        contentSize.height = bounds.height+CGFloat(cellCount)*configuration.cellSize.height
        
        return contentSize
    }
}

extension CollectionViewCircleLayout: CollectionViewLayoutProtocol {
    
    public var currentIndex: Int {
        guard let collectionView = collectionView else { return 0 }
        
        var index = Int(round(collectionView.contentOffset.y/configuration.cellSize.height))
        
        if index>=cellCount && cellCount>0 {
            index = cellCount-1
        }
        
        return index
    }
    
    public func contentOffsetFor(indexPath: IndexPath) -> CGPoint {
        var contenOffset = CGPoint.zero
        contenOffset.y = CGFloat(indexPath.item) * configuration.cellSize.height
        return contenOffset
    }
    
    public func attributesForCollectionView(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)!
        let contentOffsetY = collectionView.contentOffset.y
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        let cellSize = configuration.cellSize
        let cellWidth = cellSize.width
        var topItemIndex = contentOffsetY/cellSize.height
        topItemIndex = topItemIndex>=CGFloat(cellCount) ? topItemIndex-CGFloat(cellCount) : topItemIndex
        let visibleCount = CGFloat(max(1, cellCount))/2
        let index = CGFloat(indexPath.item)
        
        attributes.size = cellSize
        
        let itemOffset = index-topItemIndex
        let floatPI = CGFloat(Double.pi)
        let radian = CGFloat(floatPI/visibleCount*itemOffset)
        let y = height+contentOffsetY-cellWidth/2-cos(radian)*(cellWidth/2+configuration.spacing)
        let x = sin(radian)*(cellSize.width/2+configuration.spacing)+width/2
        
        attributes.center = CGPoint(x:x-configuration.offsetX, y:y-configuration.offsetY)
        attributes.zIndex = round(topItemIndex)==index ? 1000 : indexPath.item
        
        //        print("topItemIndex:\(topItemIndex) itemOffset:\(itemOffset) isHidden:\(attributes.isHidden)")
        return attributes
    }
    
}
