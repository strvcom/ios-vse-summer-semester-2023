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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code = "episode"
        case airDate
        case characterUrls = "characters"
    }
    
    init(
        id: Int,
        name: String,
        code: String,
        airDate: String,
        characterUrls: [URL]
    ) throws {
        self.id = id
        self.name = name
        self.code = code
        
        guard let date = Self.airDateFormatter.date(from: airDate) else {
            throw APIError.customDecodingFailed
        }
        
        self.airDate = date
        
        self.characterIds = characterUrls
            .compactMap {
                Int($0.lastPathComponent)
            }
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

// MARK: - Decodable
extension Episode: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
        
        let airDateString = try container.decode(String.self, forKey: .airDate)
        
        guard let date = Self.airDateFormatter.date(from: airDateString) else {
            throw APIError.customDecodingFailed
        }
        
        airDate = date
        
        let characterUrls = try container.decode([URL].self, forKey: .characterUrls)
        
        characterIds = characterUrls
            .compactMap {
                Int($0.lastPathComponent)
            }
    }
}

// MARK: - Likes
extension Episode: Likeable {
    static let likeType: LikeType = .episode
    
    var likeItemId: Int64 {
        .init(id)
    }
}

// MARK: - Mock
#if DEBUG
extension Episode {
    static let mock: Episode = try! .init(
        id: 1,
        name: "Pilot",
        code: "S01E01",
        airDate: "December 2, 2013",
        characterUrls: [
            URL(string: "https://rickandmortyapi.com/api/character/1")!,
            URL(string: "https://rickandmortyapi.com/api/character/2")!
        ]
    )
}
#endif
