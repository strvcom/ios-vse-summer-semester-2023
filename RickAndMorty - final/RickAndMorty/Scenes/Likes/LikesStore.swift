//
//  LikesStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import CoreData

@MainActor final class LikesStore: NSObject, ObservableObject {
    @Injected var coreDataManager: CoreDataManaging
    
    @Published var characters: [Like] = .init()
    @Published var episodes: [Like] = .init()
    @Published var locations: [Like] = .init()
    
    // We could have three NSFetchRequest & NSFetchedResultsController - one for each `LikeType`
    // But it seemed like a bit of a stretch...
    lazy var fetchRequest: NSFetchRequest<Like> = {
        let fetchRequest: NSFetchRequest = Like.fetchRequest()
        
        fetchRequest.sortDescriptors = [
            .init(key: "name", ascending: true)
        ]
        
        return fetchRequest
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<Like> = {
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataManager.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        controller.delegate = self
        
        return controller
    }()
    
    @MainActor override init() {
        super.init()
        
        setupLikeObservation()
    }
}

// MARK: - Core Data
extension LikesStore {
    private func setupLikeObservation() {
        try? fetchedResultsController.performFetch()
        
        updateContent()
    }
    
    func updateContent() {
        guard let likes = fetchedResultsController.fetchedObjects else {
            characters = .init()
            episodes = .init()
            locations = .init()
            
            return
        }
        
        var characters: [Like] = .init()
        var episodes: [Like] = .init()
        var locations: [Like] = .init()
        
        for like in likes {
            guard
                let likeTypeString = like.type,
                let likeType = LikeType(rawValue: likeTypeString)
            else {
                continue
            }
            
            switch likeType {
            case .character:
                characters.append(like)
            case .episode:
                episodes.append(like)
            case .location:
                locations.append(like)
            }
        }
        
        self.characters = characters
        self.episodes = episodes
        self.locations = locations
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension LikesStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateContent()
    }
}
