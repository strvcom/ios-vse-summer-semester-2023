//
//  Color+App.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

// MARK: - SwiftUI
extension Color {
    static let appBackgroundGradientTop = Color("Colors/Background/Gradient/Top")
    static let appBackgroundGradientBottom = Color("Colors/Background/Gradient/Bottom")
    static let appBackgroundItem = Color("Colors/Background/Item")
    
    static let appTextBody = Color("Colors/Text/Body")
    static let appTextSectionTitle = Color("Colors/Text/Section Title")
    static let appTextItemTitle = Color(uiColor: .appTextItemTitle)
    static let appTextNavigationBar = Color(uiColor: .appTextNavigationBar)
}

// MARK: - UIKit
extension UIColor {
    static let appBackgroundTabBar = UIColor(named: "Colors/Background/Tab Bar")!
    static let appBackgroundSegmentedControlGeneral = UIColor(named: "Colors/Background/Segmented Control/General")!
    static let appBackgroundSegmentedControlSelected = UIColor(named: "Colors/Background/Segmented Control/Selected")!
    
    static let appTextNavigationBar = UIColor(named: "Colors/Text/Navigation Bar")!
    
    static let appTintNavigationBar = UIColor(named: "Colors/Tint/Navigation Bar")!
    static let appTintTabBarSelected = UIColor(named: "Colors/Tint/Tab Bar/Selected")!
    static let appTintTabBarUnselected = UIColor(named: "Colors/Tint/Tab Bar/Unselected")!
    
    static let appTextItemTitle = UIColor(named: "Colors/Text/Item Title")!
    static let appTextItemTitleInverse = UIColor(named: "Colors/Text/Item Title Inverse")!
}
