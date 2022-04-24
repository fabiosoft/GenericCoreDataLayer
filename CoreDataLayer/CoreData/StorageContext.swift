//
//  StorageContext.swift
//  coredata
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation
import CoreData

/// Step One: Prepare a Generic DB Layer
protocol StorageContext {

    func create<DBEntity: Storable>(_ model: DBEntity.Type) -> DBEntity?

    func save(object: Storable) throws

    func saveAll(objects: [Storable]) throws

    func update(object: Storable) throws

    func delete(object: Storable) throws

    func deleteAll(_ model: Storable.Type) throws

    func fetch(_ model: Storable.Type, predicate: NSPredicate?, sorted: Sorted?) -> [Storable]
}

extension StorageContext {

    func objectWithObjectId<DBEntity: Storable>(objectId: NSManagedObjectID) -> DBEntity? {
        return nil
    }
}
