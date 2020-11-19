//
//  LayoutConfiguration.swift
//  CPCollectionViewKit
//
//  Created by Parsifal on 2017/1/22.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

import UIKit

open class LayoutConfiguration {
    
    // MARK: Properties
    public var cellSize: CGSize {
        didSet {
            if cellSize.width<=0.0 || cellSize.height<=0.0 {
                cellSize = CGSize.init(width: 50.0, height: 50.0)
            }
        }
    }
    
    public var spacing:CGFloat = 0
    public var offsetX:CGFloat = 0
    public var offsetY:CGFloat = 0
    
    // MARK: Methods
    public init(withCellSize cellSize: CGSize,
                spacing:CGFloat = 0.0,
                offsetX:CGFloat = 0.0,
                offsetY:CGFloat = 0.0) {
        self.cellSize = cellSize
        self.spacing = spacing
        self.offsetX = offsetX
        self.offsetY = offsetY
    }
}
