//
//  UIFontExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 9/16/17.
//  Copyright © 2017 SpeedySwift
//

#if canImport(UIKit)
import UIKit

// MARK: - Properties
public extension UIFont {

    /// 粗体
    public var bold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }

    /// 斜体
    public var italic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }

    /// 等宽
    ///
    ///     UIFont.preferredFont(forTextStyle: .body).monospaced
    ///
    public var monospaced: UIFont {
        let settings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]

        let attributes = [UIFontDescriptor.AttributeName.featureSettings: settings]
        let newDescriptor = fontDescriptor.addingAttributes(attributes)
        return UIFont(descriptor: newDescriptor, size: 0)
    }

}
#endif
