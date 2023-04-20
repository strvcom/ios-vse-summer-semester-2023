//
//  Episode.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

struct Episode {
    let id: Int
    let name: String
    let code: String
    let airDate: Date
    let characterIds: [Int]
    
    var rottenTomatoesUrl: URL? {
        let codeParts = code.dropFirst().split(separator: "E")
        
        guard
            codeParts.count == 2,
            let serieNumber = codeParts.first,
            let episodeNumber = codeParts.last
        else {
            return nil
        }
        
        let urlString = "https://www.rottentomatoes.com/tv/rick_and_morty/s\(serieNumber)/e\(episodeNumber)"
        
        return URL(string: urlString)
    }
}

// MARK - Date Formatter
extension Episode {
    static let airDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
}

// MARK: - Conformances
extension Episode: Identifiable {}
extension Episode: Equatable {}

// MARK: - Mock
#if DEBUG
extension Episode {
    static let mock: Episode = .init(
        id: 1,
        name: "Pilot",
        code: "S01E01",
        airDate: Date(),
        characterIds: [
            1, 2
        ]
    )
    
    static let mockedEpisodes: [Episode] = [
        .init(
            id: 1,
            name: "Pilot",
            code: "S01E01",
            airDate: Date(),
            characterIds: [
                1, 2
            ]
        ),
        .init(
            id: 2,
            name: "Planet of Ricks",
            code: "S01E02",
            airDate: Date(),
            characterIds: [
                1, 2
            ]
        ),
        .init(
            id: 3,
            name: "Marthian",
            code: "S01E03",
            airDate: Date(),
            characterIds: [
                1, 2
            ]
        )
    ]
}
#endif
