//
//  CoreDataStorageContext.swift
//  coredata
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation
import CoreData

/// Step Two: Create a Specific Implementation of the DB Layer
/// CoreDataStorageContext is the implementation of the StorageContext. This is the specific implementation 
class CoreDataStorageContext: StorageContext {

    var managedContext: NSManagedObjectContext?

    required init(configuration: ConfigurationType = .basic(identifier: "coredata_model_name")) {
        switch configuration {
        case .basic:
            initDB(modelName: configuration.identifier(), storeType: .sqLiteStoreType)
        case .inMemory:
            initDB(storeType: .inMemoryStoreType)
        }
    }

    private func initDB(modelName: String? = nil, storeType: StoreType) {
        let coordinator = CoreDataStoreCoordinator.persistentStoreCoordinator(modelName: modelName, storeType: storeType)
        self.managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.managedContext?.persistentStoreCoordinator = coordinator
    }
}

extension CoreDataStorageContext {

    func create<DBEntity: Storable>(_ model: DBEntity.Type) -> DBEntity? {
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName(from: model.self), in: managedContext!)
        let entity = NSManagedObject(entity: entityDescription!,
                                     insertInto: managedContext)
        return entity as? DBEntity
    }
    
    func save(object: Storable) throws {
        try managedContext?.save()
    }

    func saveAll(objects: [Storable]) throws {
    }

    func update(object: Storable) throws {
    }

    func delete(object: Storable) throws {
        managedContext?.delete(object as! NSManagedObject)
    }

    func deleteAll(_ model: Storable.Type) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName(from: model.self))
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext?.execute(batchDeleteRequest)
        } catch {
            // Error Handling
        }
    }

    func fetch(_ model: Storable.Type, predicate: NSPredicate?, sorted: Sorted?) -> [Storable] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName(from: model.self))
        request.predicate = predicate

        if let sorted = sorted {
            let sortDescriptor = NSSortDescriptor(key: sorted.key, ascending: sorted.ascending)
            request.sortDescriptors = [sortDescriptor]
        }
        
        do{
            let results = try managedContext?.fetch(request) as! [Storable]
            return results
        }catch{
            return []
        }
    }

    func objectWithObjectId<DBEntity: Storable>(objectId: NSManagedObjectID) -> DBEntity? {
        do {
            let result = try managedContext!.existingObject(with: objectId)
            return result as? DBEntity
        } catch {
            
        }

        return nil
    }
    
    private func entityName(from model: Storable.Type) -> String{
        return String.init(describing: model.self)
    }
}
