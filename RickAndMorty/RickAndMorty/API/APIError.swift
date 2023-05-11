//
//  APIError.swift
//  RickAndMorty
//
//  Created by Gleb on 11.05.2023.
//

import Foundation

enum APIError: Error {
    case unaceptableStatusCode
    case decodingFailed(error: Error)
    case invalidUrlComponents
}
