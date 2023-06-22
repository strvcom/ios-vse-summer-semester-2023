//
//  URL+Convenience.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

extension URL {
    func valueOf(queryParameter: String) -> String? {
        guard let url = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        return url.queryItems?
            .first { $0.name == queryParameter }?
            .value
    }
}
