//
//  ProvidedData.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import Foundation

// This enum is used to provide either the full entity (e.g. a Character)
// or its ID (when the full entity is not available) to the Stores
enum ProvidedData<T: Identifiable>: Hashable {
    case entity(T)
    case id(T.ID)
    
    var id: T.ID {
        switch self {
        case let .entity(entity):
            return entity.id
        case let .id(id):
            return id
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .entity(entity):
            hasher.combine(entity.id)
        case let .id(id):
            hasher.combine(id)
        }
    }
    
    static func == (lhs: ProvidedData<T>, rhs: ProvidedData<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.entity(entity1), .entity(entity2)):
            return entity1.id == entity2.id
        case let (.id(id1), .id(id2)):
            return id1 == id2
        default:
            return false
        }
    }
}
