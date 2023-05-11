//
//  CharacterEndpoint.swift
//  RickAndMorty
//
//  Created by Gleb on 11.05.2023.
//

import Foundation

enum CharacterEndpoint: Endpoint {
    
    case getCharacters(page: Int?)
    
    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        }
    }
    
    var urlParameters: [String : String] {
        switch self {
        case .getCharacters(let page?):
            return ["page": String(page)]
        case .getCharacters:
            return [:]
        }
        
    }
}
