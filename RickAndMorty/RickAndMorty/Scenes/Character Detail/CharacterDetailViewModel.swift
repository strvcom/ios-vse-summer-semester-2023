//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Gleb on 27.04.2023.
//

import Foundation

@MainActor final class CharacterDetailViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case fetched
        case failed
    }
    
    var id: Int?
    @Published var state: State = .initial
    @Published var character: Character?
    @Published var episodes: [Episode] = []
    
    nonisolated init(id: Int? = nil) {
        self.id = id
    }
    
    func fetch() async {
        state = .loading
     
        try! await Task.sleep(for: .seconds(2))
        
        state = .fetched
        character = Character.mock
        episodes = Episode.mockedEpisodes
    }
    
}
