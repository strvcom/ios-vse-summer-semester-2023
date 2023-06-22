//
//  NSManagedObject+Convenience.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import CoreData

extension NSManagedObject {
    // This exists so that CoreData does not complain with following error when using CloudKit
    // CoreData: warning:       'Like' (0x6000001bb700) from NSManagedObjectModel (0x60000151fca0) claims 'Like'.
    convenience init(safeContext context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        
        self.init(entity: entity, insertInto: context)
    }
}
