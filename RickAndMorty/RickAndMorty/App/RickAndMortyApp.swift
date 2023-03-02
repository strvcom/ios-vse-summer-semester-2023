//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    init() {
        setupNavigationBarAppearance()
        setupTabBarAppearance()
        setupSegmentedControlAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - UIKit shenanigans
private extension RickAndMortyApp {
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [
            .font: UIFont.appNavigationBarCompact,
            .foregroundColor: UIColor.appTextNavigationBar
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont.appNavigationBarLarge,
            .foregroundColor: UIColor.appTextNavigationBar
        ]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        let standardAppearance = appearance.copy()
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.backgroundColor = .appBackgroundTabBar
        
        UINavigationBar.appearance().standardAppearance = standardAppearance
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .appTintNavigationBar
    }

    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .appBackgroundTabBar
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: UIFont.appTabBar,
            .foregroundColor: UIColor.appTintTabBarUnselected
        ]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: UIFont.appTabBar,
            .foregroundColor: UIColor.appTintTabBarSelected
        ]
        appearance.stackedLayoutAppearance.normal.iconColor = .appTintTabBarUnselected
        appearance.stackedLayoutAppearance.selected.iconColor = .appTintTabBarSelected
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func setupSegmentedControlAppearance() {
        UISegmentedControl.appearance().backgroundColor = .appBackgroundSegmentedControlGeneral
        UISegmentedControl.appearance().selectedSegmentTintColor = .appBackgroundSegmentedControlSelected
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.appTextItemTitleInverse],
            for: .normal
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.appTextItemTitle],
            for: .selected
        )
    }
}
