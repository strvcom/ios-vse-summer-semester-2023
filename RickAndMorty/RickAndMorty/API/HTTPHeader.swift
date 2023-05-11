//
//  HTTPHeader.swift
//  RickAndMorty
//
//  Created by Gleb on 11.05.2023.
//

import Foundation

enum HTTPHeader {
    enum HeaderField: String {
        case contentType = "Content-Type"
    }

    enum ContentType: String {
        case json = "application/json"
        case text = "text/html;charset=utf-8"
    }
}
