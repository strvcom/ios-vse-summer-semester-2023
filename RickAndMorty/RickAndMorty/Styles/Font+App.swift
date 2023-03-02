//
//  Font+App.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

// MARK: - SwiftUI
extension Font {
    static func clashDisplayVariableBoldSemibold(ofSize size: CGFloat, relativeTo textStyle: Font.TextStyle) -> Font {
        .custom("ClashDisplayVariable-Bold_Semibold", size: size, relativeTo: textStyle)
    }
    
    static func satoshiVariableBoldBold(ofSize size: CGFloat, relativeTo textStyle: Font.TextStyle) -> Font {
        .custom("SatoshiVariable-Bold_Bold", size: size, relativeTo: textStyle)
    }
}

extension Font {
    static let appSectionTitle = clashDisplayVariableBoldSemibold(ofSize: 18, relativeTo: .title)
    
    static let appItemLargeTitle = clashDisplayVariableBoldSemibold(ofSize: 18, relativeTo: .title)
    static let appItemSmallTitle = clashDisplayVariableBoldSemibold(ofSize: 13, relativeTo: .title)
    static let appItemDescription = clashDisplayVariableBoldSemibold(ofSize: 13, relativeTo: .body)
}

// MARK: - UIKit
extension UIFont {
    static func clashDisplayVariableBoldSemibold(ofSize size: CGFloat) -> UIFont {
        .init(name: "ClashDisplayVariable-Bold_Semibold", size: size)!
    }
}

extension UIFont {
    static let appNavigationBarLargeBase = clashDisplayVariableBoldSemibold(ofSize: 34)
    static let appNavigationBarLarge = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: .appNavigationBarLargeBase)
    
    static let appNavigationBarCompactBase = clashDisplayVariableBoldSemibold(ofSize: 18)
    static let appNavigationBarCompact = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: .appNavigationBarCompactBase)
    
    static let appTabBarBase = clashDisplayVariableBoldSemibold(ofSize: 11)
    static let appTabBar = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: .appTabBarBase)
}
