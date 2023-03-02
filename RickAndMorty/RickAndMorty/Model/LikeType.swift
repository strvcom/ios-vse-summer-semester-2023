//
//  LikeType.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import Foundation

enum LikeType: String {
    case character
    case episode
    case location
    
    var title: String {
        switch self {
        case .character:
            return "Characters"
        case .episode:
            return "Episodes"
        case .location:
            return "Locations"
        }
    }
}

// MARK: - Conformances
extension LikeType: CaseIterable {}

extension LikeType: Identifiable {
    var id: String {
        rawValue
    }
}
