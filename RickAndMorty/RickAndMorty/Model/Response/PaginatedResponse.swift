//
//  PaginatedResponse.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

struct PaginatedResponse<T: Decodable> {
    let info: PaginationInfo
    let results: [T]
}

extension PaginatedResponse: Decodable {}
