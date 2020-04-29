//
//  UINavigationItemExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 9/28/16.
//  Copyright © 2016 SpeedySwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UINavigationItem {

    /// 用图片替换文字
    ///
    /// - Parameter image: UIImage to replace title with.
    public func replaceTitle(with image: UIImage) {
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = image
        titleView = logoImageView
    }

}
#endif
