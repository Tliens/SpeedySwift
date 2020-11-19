//
//  CollectionViewStageLayout.swift
//  CPCollectionViewKit
//
//  Created by Parsifal on 2017/2/17.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import Foundation
import UIKit
public enum MoveAnimationStyle {
    case none
    case waltz
    case somefault
}

public enum LeaveStageAnimationStyle {
    case fadeAway
    case zoomin
    case outOfBoundary
    case fadeAwayAndZoomin
    case blend
}

open class StageLayoutConfiguration: LayoutConfiguration {
    
    public var topCellSize = CGSize(width: 100, height: 100)
    public var moveAnimationStyle: MoveAnimationStyle = .none
    public var leaveStageAnimationStyle: LeaveStageAnimationStyle = .fadeAway
    
}

open class CollectionViewStageLayout: CollectionViewLayout {
    
    public var configuration: StageLayoutConfiguration
    
    public init(withConfiguration configuration: StageLayoutConfiguration) {
        self.configuration = configuration
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.configuration =  StageLayoutConfiguration(withCellSize: CGSize(width: 100, height: 100))
        super.init(coder: aDecoder)
    }

    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { return super.layoutAttributesForItem(at: indexPath) }
        return attributesForCollectionView(collectionView: collectionView, indexPath: indexPath)
    }
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard collectionView != nil else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        let topIndexItem = proposedContentOffset.x / configuration.cellSize.width
        let x = round(topIndexItem) * (configuration.cellSize.width)
        let y = proposedContentOffset.y
        return CGPoint(x: x, y: y)
    }
    
    open override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return super.collectionViewContentSize }
        let cellWidth = configuration.cellSize.width
        let width = CGFloat(cellCount - 1) * cellWidth+collectionView.bounds.width
        return CGSize(width: width, height: collectionView.bounds.width)
    }

}

extension CollectionViewStageLayout: CollectionViewLayoutProtocol {
    
    public var currentIndex: Int {
        if let collectionView = collectionView {
            var index = Int(round(collectionView.contentOffset.x / configuration.cellSize.width))
            
            if index>=cellCount && cellCount>0 {
                index = cellCount - 1
            }
            
            return index
        }
        
        return 0
    }
    
    public func contentOffsetFor(indexPath: IndexPath) -> CGPoint {
        var contentOffset = CGPoint.zero
        contentOffset.x = CGFloat(indexPath.item) * configuration.cellSize.width
        return contentOffset
    }
    
    open func attributesForCollectionView(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath) else {
            return nil
        }
        
        let item = CGFloat(indexPath.item)
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        var cellSize = configuration.cellSize
        let topCellSize = configuration.topCellSize
        let cellHeight = cellSize.height
        let cellWidth = cellSize.width
        var centerX: CGFloat = 0.0
        var centerY: CGFloat = 0.0
        let topItemIndex = collectionView.contentOffset.x / cellWidth
        let itemOffset = item - topItemIndex
        
        attributes.isHidden = false
        
        if itemOffset > -1 && itemOffset <= 0 {
            if configuration.leaveStageAnimationStyle == .outOfBoundary
                || configuration.leaveStageAnimationStyle == .blend{
                centerX = collectionView.contentOffset.x + (abs(itemOffset) + 0.5) * width
            } else {
                centerX = collectionView.contentOffset.x + 0.5 * width
            }
            centerY = (height - cellHeight) / 2
            
            if configuration.leaveStageAnimationStyle == .fadeAway
                || configuration.leaveStageAnimationStyle == .fadeAwayAndZoomin
                || configuration.leaveStageAnimationStyle == .blend {
                attributes.alpha = (1 + itemOffset)
            } else {
                attributes.alpha = 1
            }
            
            if configuration.leaveStageAnimationStyle == .zoomin
                || configuration.leaveStageAnimationStyle == .fadeAwayAndZoomin
                || configuration.leaveStageAnimationStyle == .blend {
                cellSize = CGSize(width: (1 + itemOffset) * topCellSize.width,
                                  height: (1 + itemOffset) * topCellSize.height)
            } else {
                cellSize = topCellSize
            }
        } else if itemOffset <= 1 && itemOffset > 0 {
            centerX = ((width - cellWidth) / 2) * (1 - itemOffset) + cellWidth / 2 + collectionView.contentOffset.x
            centerY = (height / 2) * (itemOffset) + (height - cellHeight) / 2
            cellSize = CGSize(width: (cellWidth - topCellSize.width) * itemOffset + topCellSize.width,
                              height: (cellHeight - topCellSize.height) * itemOffset + topCellSize.height)
        } else if itemOffset > 1 {
            centerX = collectionView.contentOffset.x + (itemOffset - 0.5) * cellWidth + (itemOffset - 1) * configuration.spacing
            centerY = height - cellHeight / 2
        } else {
            attributes.isHidden = true
            centerX = collectionView.contentOffset.x + (itemOffset + 0.5) * cellWidth + (itemOffset) * configuration.spacing
            centerY = height - cellHeight / 2
        }
        
        let rotateFactor = abs(itemOffset * 100).remainder(dividingBy: 100) / 100
        
        switch configuration.moveAnimationStyle {
        case .waltz where itemOffset > 0:
            attributes.transform3D =  CATransform3DRotate(attributes.transform3D, CGFloat(Double.pi * 2) * rotateFactor, 0, 1, 0)
        case .somefault where itemOffset > 0:
            attributes.transform3D =  CATransform3DRotate(attributes.transform3D, CGFloat(Double.pi * 2) * rotateFactor, 0, 0, 1)
        default:
            attributes.transform3D = CATransform3DIdentity
        }
        
        //        print("item:\(item) itemOffset:\(itemOffset) topItemIndex:\(topItemIndex)")
        
        attributes.size = cellSize
        attributes.center = CGPoint(x: centerX + configuration.offsetX,
                                    y: centerY + configuration.offsetY)
        
        return attributes
    }
    
}
