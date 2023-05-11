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
        case fetched(loadingMore: Bool)
        case failed
    }
    
    @Injected private var apiManager: APIManaging
    
    private var currentPageInfo: Response<[Character]>.Info?
    
    @Published var characters: [Character] = []
    @Published var state: State = .initial
    
    
    func fetchMoreIfNeeded(for character: Character) async {
        
        guard character == characters.last else {
            return
        }
        
        guard let page = currentPageInfo?.next else {
            return
        }
        
        state = .fetched(loadingMore: true)
        
        await fetch(page: page)
    }
    
    
    func load() async {
        state = .loading
        await fetch()
    }
    
    
    func fetch(page: Int? = nil) async {
        
        do {
            
            let endpoint = CharacterEndpoint.getCharacters(page: page)
            
            let response: Response<[Character]> = try await apiManager.request(endpoint: endpoint)
            
            currentPageInfo = response.info
            characters += response.results
            
            state = .fetched(loadingMore: false)
        } catch {
            
            if let error = error as? URLError, error.code == .cancelled {
                Logger.log("URL request was cancelled", .info)
                
                state = .fetched(loadingMore: false)
                
                return
            }
            
            debugPrint(error)
            state = .failed
        }
    }
}
