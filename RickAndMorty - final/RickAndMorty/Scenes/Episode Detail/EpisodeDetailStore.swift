//
//  EpisodeDetailStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import CoreData

@MainActor final class EpisodeDetailStore: NSObject, ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case finished
        case failed
    }
    
    @Injected var coreDataManager: CoreDataManaging
    @Injected private var apiManager: APIManaging
    
    @Published var state: State = .initial
    @Published var episode: Episode?
    @Published var characters: [Character] = .init()
    @Published var isLiked: Bool = false
    
    lazy nonisolated var fetchedResultsController: NSFetchedResultsController<Like> = makeFetchedResultsController()
    
    let providedData: ProvidedData<Episode>
    
    init(providedData: ProvidedData<Episode>) {
        self.providedData = providedData
        
        if case let .entity(episode) = providedData {
            self.episode = episode
            
            state = .finished
        }
        super.init()
        
        setupLikeObservation()
    }
}

// MARK: - Actions
extension EpisodeDetailStore {
    func load() async {
        if case let .id(id) = providedData {
            await fetchEpisode(with: id)
        }
        
        await fetchCharacters()
    }
}

// MARK: - Fetching
extension EpisodeDetailStore {
    private func fetchEpisode(with id: Episode.ID) async {
        let endpoint = EpisodesAPIRouter.getEpisode(id: id)
        
        do {
            episode = try await apiManager.request(endpoint)
            
            state = .finished
        } catch {
            Logger.log("\(error)", .error)
            
            state = .failed
        }
    }
    
    private func fetchCharacters() async {
        guard let episode = episode else {
            return
        }
        
        do {
            try await withThrowingTaskGroup(of: Character.self) { [weak self] group in
                guard let self = self else {
                    return
                }
                
                for characterId in episode.characterIds {
                    group.addTask {
                        let endpoint = CharactersAPIRouter.getCharacter(id: characterId)
                        
                        return try await self.apiManager.request(endpoint)
                    }
                }
                
                var characters: [Character] = .init()
                
                for try await character in group {
                    characters.append(character)
                }
                
                self.characters = characters
            }
        } catch {
            Logger.log("\(error)", .error)
            // List of characters is not *that* important, so we'll ignore any errors
        }
    }
}

// MARK: - Likes
extension EpisodeDetailStore: EntityLiking {
    var likeableEntity: Episode? {
        episode
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateLikeStatus()
    }
}
