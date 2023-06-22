//
//  EntityLiking.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import CoreData

protocol EntityLiking: NSFetchedResultsControllerDelegate {
    associatedtype T: Identifiable, Likeable where T.ID == Int
    
    var coreDataManager: CoreDataManaging { get }
    var providedData: ProvidedData<T> { get }
    var fetchedResultsController: NSFetchedResultsController<Like> { get }
    
    @MainActor var likeableEntity: T? { get }
    @MainActor var isLiked: Bool { get set }
    
    @MainActor func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
}

// MARK: - NSFetchRequest
extension EntityLiking {
    var fetchRequest: NSFetchRequest<Like> {
        let fetchRequest: NSFetchRequest = Like.fetchRequest()
        
        fetchRequest.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                .init(format: "type == %@", T.likeType.rawValue),
                .init(format: "itemId == %i", providedData.id),
            ]
        )
        
        fetchRequest.sortDescriptors = [
            .init(key: "itemId", ascending: true)
        ]
        
        return fetchRequest
    }
}

// MARK: - NSFetchedResultsController
extension EntityLiking {
    func makeFetchedResultsController() -> NSFetchedResultsController<Like> {
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataManager.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        controller.delegate = self
        
        return controller
    }
}

// MARK: - Actions
extension EntityLiking {
    func toggleLike() async {
        await isLiked ?
            unlike() :
            like()
    }
    
    func like() async {
        guard let entity = await likeableEntity else {
            return
        }
        
        let context = coreDataManager.persistentContainer.newBackgroundContext()
        
        try? await context.perform {
            let like = Like(safeContext: context)
            
            like.type = T.likeType.rawValue
            like.itemId = entity.likeItemId
            like.name = entity.name
            
            try context.save()
        }
    }
    
    func unlike() async {
        let context = coreDataManager.persistentContainer.newBackgroundContext()
        
        try? await context.perform {
            let likes = try context.fetch(self.fetchRequest)
            
            for like in likes {
                context.delete(like)
            }
            
            try context.save()
        }
    }
    
    @MainActor func setupLikeObservation() {
        try? fetchedResultsController.performFetch()
        
        updateLikeStatus()
    }
    
    @MainActor func updateLikeStatus() {
        isLiked = fetchedResultsController.fetchedObjects?.count != 0
    }
}
