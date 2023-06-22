//
//  CoreDataManager.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import CoreData
import CloudKit

protocol CoreDataManaging {
    var persistentContainer: NSPersistentCloudKitContainer { get }
    var viewContext: NSManagedObjectContext { get }
}

class CoreDataManager: CoreDataManaging {
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "RickAndMorty")
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No descriptions present")
        }

        // Needed for processing the remote notifications
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data persistence container: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
        if let storeUrl = container.persistentStoreCoordinator.persistentStores.first?.url {
            Logger.log("Store location: \(storeUrl)")
        }
        
        return container
    }()

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

// MARK: - Mock
#if DEBUG
extension CoreDataManager {
    static let shared = CoreDataManager()
}
#endif
