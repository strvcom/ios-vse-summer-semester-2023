//
//  CharactersListStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

@MainActor final class CharactersListStore: ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case finished(loadingMore: Bool)
        case failed
    }
    
    @Injected private var apiManager: APIManaging
    
    @Published var state: State = .initial
    @Published var characters: [Character] = .init()
    
    private var currentResponseInfo: PaginationInfo? = nil
}

// MARK: - Actions
extension CharactersListStore {
    func load() async {
        state = .loading
        
        await fetch()
    }
    
    func loadMoreIfNeeded(for character: Character) async {
        guard character == characters.last else {
            return
        }
        
        guard let nextPageNumber = currentResponseInfo?.nextPageNumber else {
            return
        }
        
        state = .finished(loadingMore: true)
        
        await fetch(page: nextPageNumber)
    }
}

// MARK: - Fetching
private extension CharactersListStore {
    func fetch(page: Int? = nil) async {
        let endpoint = CharactersAPIRouter.getCharacters(page: page)
        
        do {
            let response: PaginatedResponse<Character> = try await apiManager.request(endpoint)
            
            currentResponseInfo = response.info
            characters += response.results
            
            state = .finished(loadingMore: false)
        } catch {
            if let error = error as? URLError, error.code == .cancelled {
                Logger.log("URL request was cancelled", .info)
                
                state = .finished(loadingMore: false)
                
                return
            }
            
            Logger.log("\(error)", .error)
            
            state = .failed
        }
    }
}
