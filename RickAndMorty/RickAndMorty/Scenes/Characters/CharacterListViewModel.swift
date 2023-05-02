//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Gleb on 27.04.2023.
//

import Foundation


@MainActor final class CharacterListViewModel: ObservableObject {

    enum State {
        case initial
        case loading
        case fetched(characters: [Character])
        case failed
    }
    
    @Published var state: State = .initial
    
    func fetch() async {
        state = .loading
        
        try! await Task.sleep(for: .seconds(2))

        state = .fetched(characters: Character.characters)
    }
}
