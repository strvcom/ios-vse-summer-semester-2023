//
//  EpisodesAPIRouter.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

enum EpisodesAPIRouter {
    case getEpisodes(page: Int?)
    case getEpisode(id: Episode.ID)
}

extension EpisodesAPIRouter: Endpoint {
    var path: String {
        switch self {
        case .getEpisodes:
            return "episode"
        case let .getEpisode(id):
            return "episode/\(id)"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var urlParameters: [String: Any]? {
        switch self {
        case let .getEpisodes(.some(page)):
            return ["page": page]
        case .getEpisodes, .getEpisode:
            return nil
        }
    }

    var headers: [String: String]? {
        nil
    }
}
