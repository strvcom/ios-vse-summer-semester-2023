//
//  LocationsListStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

@MainActor final class LocationsListStore: ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case finished(loadingMore: Bool)
        case failed
    }
    
    @Injected private var apiManager: APIManaging
    
    @Published var state: State = .initial
    @Published var locations: [Location] = .init()
    
    private var currentResponseInfo: PaginationInfo? = nil
}

// MARK: - Actions
extension LocationsListStore {
    func load() async {
        state = .loading
        
        await fetch()
    }
    
    func loadMoreIfNeeded(for location: Location) async {
        guard location == locations.last else {
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
extension LocationsListStore {
    private func fetch(page: Int? = nil) async {
        let endpoint = LocationsAPIRouter.getLocations(page: page)
        
        do {
            let response: PaginatedResponse<Location> = try await apiManager.request(endpoint)
            
            currentResponseInfo = response.info
            locations += response.results
            
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
