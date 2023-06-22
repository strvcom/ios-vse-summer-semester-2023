//
//  CharactersAPIRouter.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

enum CharactersAPIRouter {
    case getCharacters(page: Int?)
    case getCharacter(id: Character.ID)
}

extension CharactersAPIRouter: Endpoint {
    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        case let .getCharacter(id):
            return "character/\(id)"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var urlParameters: [String: Any]? {
        switch self {
        case let .getCharacters(.some(page)):
            return ["page": page]
        case .getCharacters, .getCharacter:
            return nil
        }
    }

    var headers: [String: String]? {
        nil
    }
}
