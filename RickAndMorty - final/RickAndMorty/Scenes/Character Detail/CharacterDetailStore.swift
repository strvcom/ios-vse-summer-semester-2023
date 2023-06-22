//
//  CharacterDetailStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import CoreData

@MainActor final class CharacterDetailStore: NSObject, ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case finished
        case failed
    }
    
    @Injected var coreDataManager: CoreDataManaging
    @Injected private var apiManager: APIManaging
    
    @Published var state: State = .initial
    @Published var character: Character?
    @Published var episodes: [Episode] = .init()
    @Published var isLiked: Bool = false
    
    lazy nonisolated var fetchedResultsController: NSFetchedResultsController<Like> = makeFetchedResultsController()
    
    let providedData: ProvidedData<Character>
    
    init(providedData: ProvidedData<Character>) {
        self.providedData = providedData
        
        if case let .entity(character) = providedData {
            self.character = character
            
            state = .finished
        }

        super.init()
        
        setupLikeObservation()
    }
}

// MARK: - Actions
extension CharacterDetailStore {
    func load() async {
        if case let .id(id) = providedData {
            await fetchCharacter(with: id)
        }
        
        await fetchEpisodes()
    }
}

// MARK: - Fetching
private extension CharacterDetailStore {
    func fetchCharacter(with id: Character.ID) async {
        let endpoint = CharactersAPIRouter.getCharacter(id: id)
        
        do {
            character = try await apiManager.request(endpoint)
            
            state = .finished
        } catch {
            Logger.log("\(error)", .error)
            
            state = .failed
        }
    }
    
    func fetchEpisodes() async {
        guard let character = character else {
            return
        }
        
        do {
            try await withThrowingTaskGroup(of: Episode.self) { [weak self] group in
                guard let self = self else {
                    return
                }
                
                for episodeId in character.episodeIds {
                    group.addTask {
                        let endpoint = EpisodesAPIRouter.getEpisode(id: episodeId)
                        
                        return try await self.apiManager.request(endpoint)
                    }
                }
                
                var episodes: [Episode] = .init()
                
                for try await episode in group {
                    episodes.append(episode)
                }
                
                self.episodes = episodes
            }
        } catch {
            Logger.log("\(error)", .error)
            // List of episodes is not *that* important, so we'll ignore any errors
        }
    }
}

// MARK: - Likes
extension CharacterDetailStore: EntityLiking {
    var likeableEntity: Character? {
        character
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateLikeStatus()
    }
}
