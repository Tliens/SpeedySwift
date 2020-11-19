//
//  CollectionViewCaterpillarLayout.swift
//  CPCollectionViewKit
//
//  Created by Parsifal on 2017/1/21.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import Foundation
import UIKit
open class CaterpillarLayoutConfiguration:LayoutConfiguration {
    
    // MARK: Properties
    public var topCellSizeScale:CGFloat
    public var visibleCount:Int = 1
    public var fadeAway: Bool = true

    // MARK: Methods
    public init(withCellSize cellSize:CGSize,
                         visibleCount:Int,
                             fadeAway:Bool = true,
                     topCellSizeScale:CGFloat = 1.0,
                              spacing:CGFloat = 0.0,
                              offsetX:CGFloat = 0.0,
                              offsetY:CGFloat = 0.0) {
        self.topCellSizeScale = topCellSizeScale
        self.visibleCount = visibleCount
        self.fadeAway = fadeAway
        super.init(withCellSize:cellSize,
                        spacing:spacing,
                        offsetX:offsetX,
                        offsetY:offsetY)
    }
    
}

open class CollectionViewCaterpillarLayout:CollectionViewLayout {
    open var configuration: CaterpillarLayoutConfiguration
    
    // MARK: Properties
    public init(withConfiguration configuration:CaterpillarLayoutConfiguration) {
        self.configuration = configuration
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.configuration = CaterpillarLayoutConfiguration.init(withCellSize: CGSize(width: 50, height: 50), visibleCount: 1)
        super.init(coder: aDecoder)
    }

    // MARK: Methods
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)!
        guard let collectionView = collectionView else { return attributes }
        
        let floatCellCount = CGFloat(cellCount)
        let contentOffsetY = collectionView.contentOffset.y
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        let cellSize = configuration.cellSize
        let topCellSizeScale = configuration.topCellSizeScale
        let cellWidth = cellSize.width
        let cellSpacing = configuration.spacing
        
        var topItemIndex = contentOffsetY/cellSize.height
        topItemIndex = topItemIndex>=floatCellCount ? topItemIndex-floatCellCount : topItemIndex
        topItemIndex = topItemIndex<0 ? topItemIndex+floatCellCount : topItemIndex
        
        let visibleCount = CGFloat(min(configuration.visibleCount, cellCount))/2
        let index = CGFloat(indexPath.item)
        
        attributes.size = configuration.cellSize
        attributes.isHidden = false
        
        var itemOffset = index-topItemIndex
        
        if itemOffset<0 && itemOffset >= -1.0 ||
           itemOffset>=0 && itemOffset<=1 ||
           itemOffset>0 && floatCellCount-itemOffset<=1 ||
           itemOffset<0 && floatCellCount+itemOffset<=1 {
            if itemOffset>0 && floatCellCount-itemOffset<=1 {
                itemOffset -= floatCellCount
            }
            if itemOffset<0 && floatCellCount+itemOffset<=1 {
                itemOffset += floatCellCount
            }
            // y = (1-s)x+s
            let scaleFactor:CGFloat = (1-topCellSizeScale)*abs(itemOffset)+topCellSizeScale
            attributes.size = CGSize(width:cellSize.width*scaleFactor,
                                     height:cellSize.height*scaleFactor)

            // circle
            let floatPI = CGFloat(Double.pi)
            let radian = CGFloat(floatPI/2*itemOffset)
            let x = sin(radian)*(cellSpacing/2)+width/2
            let y = height/2+contentOffsetY-cos(radian)*(cellSpacing/2)
            attributes.center = CGPoint(x:x, y:y)
        } else if abs(itemOffset)<visibleCount ||
                  itemOffset>0 && (floatCellCount-itemOffset<visibleCount) ||
                  itemOffset<0 && (floatCellCount+itemOffset<visibleCount){
            if itemOffset>0 && (floatCellCount-itemOffset<visibleCount) {
                itemOffset -= floatCellCount
            }
            
            if itemOffset<0 && (floatCellCount+itemOffset<visibleCount) {
                itemOffset += floatCellCount
            }
            // vetical linear
            let x = itemOffset>0 ? (width/2+cellSpacing/2) : (width/2-cellSpacing/2)
            let y = height/2+contentOffsetY+(abs(itemOffset)-1)*cellSpacing/2
            attributes.center = CGPoint(x:x, y:y)
        } else {
            attributes.center = CGPoint(x:-cellWidth,
                                        y:height+contentOffsetY+cellSize.height)
            attributes.isHidden = true
        }
        
        attributes.center = CGPoint(x:attributes.center.x+configuration.offsetX,
                                    y:attributes.center.y+configuration.offsetY)
        
        if configuration.fadeAway {
            attributes.alpha = 1-abs(itemOffset)/visibleCount
        }
//        print("index:\(index)topItemIndex:\(topItemIndex) itemOffset:\(itemOffset) isHidden:\(attributes.isHidden)")
        return attributes
    }
    
    open override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return CGSize.zero }
        
        let bounds = collectionView.bounds.size
        var contentSize = CGSize(width: CGFloat(), height: CGFloat())
        contentSize.width = bounds.width
        contentSize.height = bounds.height+CGFloat(cellCount)*configuration.cellSize.height
        
        return contentSize
    }
}
