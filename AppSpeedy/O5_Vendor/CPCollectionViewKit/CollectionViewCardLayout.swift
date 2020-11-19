//
//  CollectionViewCardLayout.swift
//  CPCollectionViewKit
//
//  Created by Parsifal on 2017/2/13.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import Foundation
import UIKit
public enum CardRotationAxis {
    case x
    case y
    case z
}

public enum CardScrollDiretion {
    case horizontal
    case vertical
}

open class CardLayoutConfiguration: LayoutConfiguration {
    
    public var fadeFactor: CGFloat = 0//(0,1)
    public var scaleFactorX: CGFloat = 0//zoomin:(-1,0) zoomout:(0,1)
    public var scaleFactorY: CGFloat = 0//zoomin:(-1,0) zoomout:(0,1)
    public var rotateFactor: CGFloat = 0
    public var rotateDirection: CardRotationAxis = .z
    public var stopAtItemBoundary: Bool = true
    public var scrollDirection: CardScrollDiretion = .horizontal
    
}

open class CollectionViewCardLayout: CollectionViewLayout {
    
    public var configuration: CardLayoutConfiguration
    public var currentIndex: Int {
        guard let collectionView = collectionView else { return 0 }
        
        let contentOffset = configuration.scrollDirection == .horizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        var index = Int(round(calculateTopItemIndex(contentOffset: contentOffset)))
        
        if index>=cellCount && cellCount>0 {
            index = cellCount-1
        }
        
        return index
    }
    
    public init(withConfiguration configuration: CardLayoutConfiguration) {
        self.configuration = configuration
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.configuration =  CardLayoutConfiguration(withCellSize: CGSize(width: 100, height: 100))
        super.init(coder: aDecoder)
    }
    
    open override func prepare() {
        super.prepare()
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let collectionView = collectionView,
              let attributes = super.layoutAttributesForItem(at: indexPath) else { return  super.layoutAttributesForItem(at: indexPath) }
        
        let item = CGFloat(indexPath.item)
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        let cellSize = configuration.cellSize
        let cellWidth = cellSize.width
        let cellHeight = cellSize.height
        var centerX: CGFloat = 0.0
        var centerY: CGFloat = 0.0
        let contentOffset = configuration.scrollDirection == .horizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        let topItemIndex = calculateTopItemIndex(contentOffset: contentOffset)
        let itemOffset = item-topItemIndex
        
        attributes.size = cellSize
        if configuration.scrollDirection == .horizontal {
            centerX = (item+0.5)*cellWidth+item*configuration.spacing
            centerY = height/2.0
        } else {
            centerX = width/2.0
            centerY = (item+0.5)*cellHeight+item*configuration.spacing
        }
        
        attributes.center = CGPoint(x: centerX+configuration.offsetX, y: centerY+configuration.offsetY)
        
        attributes.alpha = 1-configuration.fadeFactor*abs(itemOffset)

        let scaleFactorX = abs(1-configuration.scaleFactorX*abs(itemOffset))
        let scaleFactorY = abs(1-configuration.scaleFactorY*abs(itemOffset))
        let rotateFactor = configuration.rotateFactor*itemOffset
        
        var transform3D = CATransform3DIdentity
        transform3D.m34 = -1/550
        transform3D = CATransform3DScale(transform3D, scaleFactorX, scaleFactorY, 1)
        switch configuration.rotateDirection {
        case .x:
            transform3D = CATransform3DRotate(transform3D, rotateFactor, 1, 0, 0)
        case .y:
            transform3D = CATransform3DRotate(transform3D, rotateFactor, 0, 1, 0)
        default:
            transform3D = CATransform3DRotate(transform3D, rotateFactor, 0, 0, 1)
        }
        attributes.transform3D = transform3D
        attributes.zIndex = (itemOffset<0.5 && itemOffset > -0.5) ? 1000 : Int(item)
        
//        print("index:\(item) topItemIndex:\(topItemIndex) itemOffset:\(itemOffset)")
        return attributes
    }
    
    func calculateTopItemIndex(contentOffset: CGFloat) -> CGFloat {
        let cellWidth = configuration.cellSize.width
        let cellHeight = configuration.cellSize.height
        if configuration.scrollDirection == .horizontal {
            guard cellWidth+configuration.spacing != 0 else { return 0 }
            return  (contentOffset)/(cellWidth+configuration.spacing)
        } else {
            guard cellHeight+configuration.spacing != 0 else { return 0 }
            return  (contentOffset)/(cellHeight+configuration.spacing)
        }
    }
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard configuration.stopAtItemBoundary else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let cellWidth = configuration.cellSize.width
        let cellHeight = configuration.cellSize.height
        
        var contentOffset = CGPoint(x: CGFloat(), y: CGFloat())
        
        if configuration.scrollDirection == .horizontal {
            let topItemIndex = round(calculateTopItemIndex(contentOffset: proposedContentOffset.x))
            contentOffset.x = (cellWidth+configuration.spacing)*topItemIndex
            contentOffset.y = proposedContentOffset.y
        } else {
            let topItemIndex = round(calculateTopItemIndex(contentOffset: proposedContentOffset.y))
            contentOffset.x = proposedContentOffset.x
            contentOffset.y =  (cellHeight+configuration.spacing)*topItemIndex
        }
        
        return contentOffset
    }
    
    open override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else {
            return nil
        }
        
        if updateAnimationStyle == .custom && insertIndexPaths.contains(itemIndexPath) {
            var centerX = attributes.center.x
            var centerY = attributes.center.y
            
            if configuration.scrollDirection == .horizontal {
                centerY = 0
            } else {
                centerX = 0
            }
            
            attributes.center = CGPoint(x: centerX, y: centerY)
        }
        
        return attributes
    }
    
    open override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else {
            return nil
        }
        
        if updateAnimationStyle == .custom && deleteIndexPaths.contains(itemIndexPath) {
            var centerX = attributes.center.x
            var centerY = attributes.center.y
            
            if configuration.scrollDirection == .horizontal {
                centerY = collectionView!.bounds.height
            } else {
                centerX = collectionView!.bounds.width
            }
            
            attributes.center = CGPoint(x: centerX, y: centerY)
        }
        
        return attributes
    }
    
    open override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return super.collectionViewContentSize }
        
        let cellWidth = configuration.cellSize.width
        let cellHeight = configuration.cellSize.height
        let spacing = configuration.spacing
        var contentSize = CGSize(width: CGFloat(), height: CGFloat())
        
        if configuration.scrollDirection == .horizontal {
            contentSize.width = CGFloat(cellCount)*cellWidth+max(CGFloat(cellCount-1), 0)*spacing+2*configuration.offsetX+collectionView.bounds.width-cellWidth
            contentSize.height = collectionView.bounds.height
        } else {
            contentSize.width = collectionView.bounds.width
            contentSize.height =  CGFloat(cellCount)*cellHeight+max(CGFloat(cellCount-1), 0)*spacing+2*configuration.offsetX+collectionView.bounds.height-cellHeight
        }

        return contentSize
    }
    
}
