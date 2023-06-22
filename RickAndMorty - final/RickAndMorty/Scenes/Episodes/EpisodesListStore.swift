//
//  EpisodesListStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

@MainActor final class EpisodesListStore: ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case finished(loadingMore: Bool)
        case failed
    }
    
    @Injected private var apiManager: APIManaging
    
    @Published var state: State = .initial
    @Published var episodes: [Episode] = .init()
    
    private var currentResponseInfo: PaginationInfo? = nil
}

// MARK: - Actions
extension EpisodesListStore {
    func load() async {
        state = .loading
        
        await fetch()
    }
    
    func loadMoreIfNeeded(for episode: Episode) async {
        guard episode == episodes.last else {
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
extension EpisodesListStore {
    private func fetch(page: Int? = nil) async {
        let endpoint = EpisodesAPIRouter.getEpisodes(page: page)
        
        do {
            let response: PaginatedResponse<Episode> = try await apiManager.request(endpoint)
            
            currentResponseInfo = response.info
            episodes += response.results
            
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
