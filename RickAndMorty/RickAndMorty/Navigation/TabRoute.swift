//
//  TabRoute.swift
//  RickAndMorty
//
//  Created by Matej Molnár on 25.10.2022.
//

import Foundation

enum TabRoute: NavigationRoute {
    case characterDetail(ProvidedData<Character>)
    case locationDetail(ProvidedData<Location>)
    case episodeDetail(ProvidedData<Episode>)
    
    static func path(from pathComponents: [String]) -> [TabRoute]? {
        var path = [TabRoute]()
        var components = pathComponents.dropFirst()
        
        while let first = components.first {
            components = components.dropFirst()
            
            if
                let idString = components.first,
                let id = Int(idString)
            {
                switch first {
                case "character":
                    path.append(.characterDetail(.id(id)))
                case "episode":
                    path.append(.episodeDetail(.id(id)))
                case "location":
                    path.append(.locationDetail(.id(id)))
                default:
                    return nil
                }
            }
            
            components = components.dropFirst()
        }
        
        return path
    }
    
    var pathComponents: [String] {
        switch self {
        case let .characterDetail(providedData):
            return ["character", "\(providedData.id)"]
        case let .episodeDetail(providedData):
            return ["episode", "\(providedData.id)"]
        case let .locationDetail(providedData):
            return ["location", "\(providedData.id)"]
        }
    }
}
