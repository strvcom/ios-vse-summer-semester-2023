//
//  Likeable.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

protocol Likeable {
    static var likeType: LikeType { get }
    
    var likeItemId: Int64 { get }
    var name: String { get }
}
