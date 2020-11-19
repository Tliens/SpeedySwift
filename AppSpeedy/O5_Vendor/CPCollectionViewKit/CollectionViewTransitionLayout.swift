//
//  CollectionViewTransitionLayout.swift
//  CPCollectionViewKit
//
//  Created by Parsifal on 2017/2/18.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

open class CollectionViewTransitionLayout: UICollectionViewTransitionLayout {
    
    public var fromContentOffset = CGPoint(x: 0, y: 0)
    public var toContentOffset = CGPoint(x: 0, y: 0)
    var attributesArray = [UICollectionViewLayoutAttributes]()
    
    open override var transitionProgress: CGFloat {
        didSet {
            transitionProgressUpdated(currentProgress: transitionProgress)
        }
    }
    
    func transitionProgressUpdated(currentProgress: CGFloat) {
        if let collectionView = collectionView {
            let fromProgress = currentProgress
            let toProgress = 1 - currentProgress
            
            var offset = CGPoint(x: 0, y: 0)
            offset.x = toProgress * fromContentOffset.x + fromProgress * toContentOffset.x
            offset.y = toProgress * fromContentOffset.y + fromProgress * toContentOffset.y
            collectionView.contentOffset = offset
        }
    }
    
    open override func prepare() {
        super.prepare()
        
        if let collectionView = collectionView {
            let cellCount = collectionView.numberOfItems(inSection: 0)
            attributesArray.removeAll()
            for index in 0..<cellCount {
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                var fromAttributes: UICollectionViewLayoutAttributes?
                var toAttributes: UICollectionViewLayoutAttributes?
                
                if let tempAttributes = (self.currentLayout as? CollectionViewLayoutProtocol)?.attributesForCollectionView(collectionView: collectionView, indexPath: indexPath) {
                    fromAttributes = tempAttributes
                } else {
                    fromAttributes = self.currentLayout.layoutAttributesForItem(at: indexPath)
                }
                
                if let tempAttributes = (self.nextLayout as? CollectionViewLayoutProtocol)?.attributesForCollectionView(collectionView: collectionView, indexPath: indexPath) {
                    toAttributes = tempAttributes
                } else {
                    toAttributes = self.nextLayout.layoutAttributesForItem(at: indexPath)
                }
                
                if let fromAttributes = fromAttributes,
                   let toAttributes = toAttributes {
                    let fx = fromAttributes.center.x
                    let fy = fromAttributes.center.y
                    let tx = toAttributes.center.x
                    let ty = toAttributes.center.y
                    
                    var center = CGPoint(x: fx, y: fy)
                    center.x = updateValue(fromValue: fx, toValue: tx)
                    center.y = fx == tx ? (updateValue(fromValue: fy, toValue: ty)) : ty + ((fy - ty) * (center.x - tx)) / (fx - tx)
                    attributes.center = center

                    //(y-y2)/(y1-y2) = (x-x2)/(x1-x2)
                    var newSize = fromAttributes.size
                    newSize.width = updateValue(fromValue: fromAttributes.size.width, toValue: toAttributes.size.width)
                    newSize.height = updateValue(fromValue: fromAttributes.size.height, toValue: toAttributes.size.height)
                    attributes.size = newSize
                    attributes.zIndex = toAttributes.zIndex
                    
                    let toAlpha = toAttributes.isHidden == true ? 0 : toAttributes.alpha
                    attributes.alpha = updateValue(fromValue: fromAttributes.alpha, toValue: toAlpha)
                    
                    var newScale = CGAffineTransform.identity
                    newScale.a = updateValue(fromValue: fromAttributes.transform.a, toValue: toAttributes.transform.a)
                    newScale.d = updateValue(fromValue: fromAttributes.transform.d, toValue: toAttributes.transform.d)
                    attributes.transform = newScale
                    
                    attributesArray.append(attributes)
                }
            }
        }
    }
    
    func updateValue(fromValue: CGFloat, toValue: CGFloat) -> CGFloat {
        return ((toValue - fromValue) * transitionProgress + fromValue)
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array = [UICollectionViewLayoutAttributes]()
        
        for attributes in attributesArray {
            if rect.intersects(attributes.frame) {
                array.append(attributes)
            }
        }
        
        return attributesArray
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
