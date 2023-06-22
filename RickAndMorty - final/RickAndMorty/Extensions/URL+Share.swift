//
//  URL+Share.swift
//  RickAndMorty
//
//  Created by Matej Molnár on 27.10.2022.
//

import Foundation

extension URL {
    static func makeShareUrl(for path: String) -> URL? {
        URL(string: "rickandmorty://strv.rickandmorty.com/\(path)")
    }
}
