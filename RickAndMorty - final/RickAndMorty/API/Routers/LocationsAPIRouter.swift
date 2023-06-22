//
//  LocationsAPIRouter.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

enum LocationsAPIRouter {
    case getLocations(page: Int?)
    case getLocation(id: Location.ID)
}

extension LocationsAPIRouter: Endpoint {
    var path: String {
        switch self {
        case .getLocations:
            return "location"
        case let .getLocation(id):
            return "location/\(id)"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var urlParameters: [String: Any]? {
        switch self {
        case let .getLocations(.some(page)):
            return ["page": page]
        case .getLocations, .getLocation:
            return nil
        }
    }

    var headers: [String: String]? {
        nil
    }
}
