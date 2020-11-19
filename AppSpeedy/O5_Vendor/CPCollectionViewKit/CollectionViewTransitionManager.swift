//
//  CPCollectionViewTransitionManager.swift
//  CPCollectionViewKit
//
//  Created by Parsifal on 2017/2/18.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

open class TransitionManager {
    
    public var toContentOffset = CGPoint(x: 0, y: 0)
    let collectionView: UICollectionView
    let toLayout: UICollectionViewLayout
    var transitionLayout: CollectionViewTransitionLayout!
    let duration: TimeInterval
    var timer: CADisplayLink!
    fileprivate var startTime: TimeInterval!
    
    public init(duration: TimeInterval, collectionView: UICollectionView, toLayout: UICollectionViewLayout) {
        self.collectionView = collectionView
        self.duration = duration
        self.toLayout = toLayout
    }

    open func startInteractiveTransition(completion: @escaping () -> Void) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        transitionLayout = collectionView.startInteractiveTransition(to: toLayout) { success, finish in
            if success && finish {
                self.collectionView.contentOffset = self.toContentOffset
                self.collectionView.reloadData()
                UIApplication.shared.endIgnoringInteractionEvents()
                completion()
            }
            } as? CollectionViewTransitionLayout
        
        startTimer()
    }
    
}

extension TransitionManager {
    
    func startTimer() {
        startTime = CACurrentMediaTime()
        timer = CADisplayLink(target: self, selector: #selector(updateTransitionProgress))
        timer.preferredFramesPerSecond = 1
        timer.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    @objc dynamic func updateTransitionProgress() {
        var progress = (timer.timestamp - startTime) / duration
        //limit [0-1]
        progress = max(0, min(1, progress))
        
        transitionLayout.transitionProgress = CGFloat(progress)
        transitionLayout.invalidateLayout()
        
        if progress == 1.0 {
            collectionView.finishInteractiveTransition()
            timer.invalidate()
        }
    }
    
}
