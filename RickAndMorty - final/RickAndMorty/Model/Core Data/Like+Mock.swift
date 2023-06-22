//
//  Like+Mock.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

#if DEBUG
extension Like {
    static let mock: Like = {
        let like = Like(safeContext: CoreDataManager.shared.viewContext)
        like.itemId = 1
        like.type = LikeType.character.rawValue
        like.name = "Rick Sanchez"
        
        return like
    }()
}
#endif
