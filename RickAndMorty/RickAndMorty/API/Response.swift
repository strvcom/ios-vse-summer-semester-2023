//
//  Response.swift
//  RickAndMorty
//
//  Created by Gleb on 11.05.2023.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    
    struct Info: Decodable {
        let pages: Int
        let count: Int
        let next: Int?
        
        enum CodingKeys: String, CodingKey {
            case pages
            case count
            case next
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            count = try container.decode(Int.self, forKey: .count)
            pages = try container.decode(Int.self, forKey: .pages)
            
            if
                let nextPageUrl = try? container.decode(URL.self, forKey: .next),
                let nextPageNumberString = nextPageUrl.valueOf(queryParameter: "page"),
                let nextPageNumber = Int(nextPageNumberString)
            {
                self.next = nextPageNumber
            } else {
                self.next = nil
            }
        }
    }
    
    let info: Info
    let results: T
}
