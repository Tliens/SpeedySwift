//
//  CollectionViewLayout.swift
//  CPCollectionViewKit
//
//  Created by Parsifal on 2017/1/22.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

public enum ItemUpdateAnimation {
    case common //iOS default delete/insert animation
    case base  // zoomin/out animation
    case custom  //custom by sublayout
}

public protocol CollectionViewLayoutProtocol {
    
    var currentIndex: Int { get }
    
    func contentOffsetFor(indexPath: IndexPath) -> CGPoint
    func attributesForCollectionView(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    
}

open class CollectionViewLayout: UICollectionViewLayout {
    // MARK: Properties
    var cellCount = 0
    var cachedAttributesArray = [UICollectionViewLayoutAttributes]()
    var deleteIndexPaths = [IndexPath]()
    var insertIndexPaths = [IndexPath]()
    public var updateAnimationStyle: ItemUpdateAnimation = .common

    // MARK: Methods
    override open func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        cellCount = collectionView.numberOfItems(inSection: 0)
        cachedAttributesArray.removeAll()
        
        for i in 0..<cellCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attrbutes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            cachedAttributesArray.append(attrbutes)
        }
    }
    
    open override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        for updateItem in updateItems {
            if updateItem.updateAction == .delete {
                guard let indexPath = updateItem.indexPathBeforeUpdate else { return }
                deleteIndexPaths.append(indexPath)
            } else if updateItem.updateAction == .insert {
                guard let indexPath = updateItem.indexPathAfterUpdate else { return }
                insertIndexPaths.append(indexPath)
            }
        }
    }
    
    open override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        deleteIndexPaths.removeAll()
        insertIndexPaths.removeAll()
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = cachedAttributesArray[indexPath.item]
        attributes.zIndex = indexPath.item
        return attributes
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleAttributesArray = [UICollectionViewLayoutAttributes]()
        
        for index in 0..<cellCount {
            let attributes = layoutAttributesForItem(at: IndexPath(row: index, section: 0))!
            if rect.intersects(attributes.frame) && !attributes.isHidden {
                visibleAttributesArray.append(attributes)
            }
        }
        
        return visibleAttributesArray
    }
    
    open override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else { return nil }
        
        if updateAnimationStyle == .base {
            if deleteIndexPaths.contains(itemIndexPath) {
                attributes.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                attributes.alpha = 0
            }
        }
        
        return attributes
    }
    
    open override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else { return nil }
        
        if updateAnimationStyle == .base {
            if insertIndexPaths.contains(itemIndexPath) {
                attributes.alpha = 1
                attributes.transform = CGAffineTransform.init(scaleX: 2, y: 2)
            }
        }
        
        return attributes
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
