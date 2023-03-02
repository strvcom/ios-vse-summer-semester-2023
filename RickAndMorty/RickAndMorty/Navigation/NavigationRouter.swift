//
//  NavigationRouter.swift
//  RickAndMorty
//
//  Created by Matej Molnár on 26.10.2022.
//

import SwiftUI

// This object holds the navigation state of the whole App.
class NavigationRouter: ObservableObject {
    @Published var selectedTab: Tab
    @Published var charactersPath: [TabRoute]
    @Published var episodesPath: [TabRoute]
    @Published var locationsPath: [TabRoute]
    @Published var likesPath: [TabRoute]
    
    private var selectedPath: [TabRoute] {
        switch selectedTab {
        case .characters: return charactersPath
        case .episodes: return episodesPath
        case .locations: return locationsPath
        case .likes: return likesPath
        }
    }
    
    init(
        selectedTab: Tab = .characters,
        charactersPath: [TabRoute] = [],
        episodesPath: [TabRoute] = [],
        locationsPath: [TabRoute] = [],
        likesPath: [TabRoute] = []
    ) {
        self.selectedTab = selectedTab
        self.charactersPath = charactersPath
        self.episodesPath = episodesPath
        self.locationsPath = locationsPath
        self.likesPath = likesPath
    }
}

// MARK: - Public
extension NavigationRouter {
    // Constructs a deeplink URL from the whole NavigationStack of the currently selected tab.
    var deeplinkURL: URL? {
        let pathString = selectedPath
            .flatMap { $0.pathComponents }
            .reduce("") { $0 + "/" + $1 }
        
        return URL.makeShareUrl(for: "\(selectedTab.rawValue)\(pathString)")
    }
    
    // Valid deeplink URL example: rickandmorty://strv.rickandmorty.com/characters/character/1/episode/1/location/1
    func executeDeepLink(url: URL) throws {
        let pathComponents = Array(url.pathComponents.drop { $0 == "/"})
        
        guard
            let tab = Tab(rawValue: pathComponents.first ?? ""),
            let path = TabRoute.path(from: pathComponents)
        else {
            throw DeepLinkError.invalidURL
        }
        
        selectedTab = tab
        
        switch tab {
        case .characters:
            charactersPath = path
        case .episodes:
            episodesPath = path
        case .locations:
            locationsPath = path
        case .likes:
            likesPath = path
        }
    }
}
