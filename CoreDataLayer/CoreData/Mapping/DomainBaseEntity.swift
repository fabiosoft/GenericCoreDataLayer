//
//  DomainBaseEntity.swift
//  coredata_test
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation
import CoreData


/// I created a base entity for all of my domain entities. All domain entities should inherit from this DomainBaseEntity
class DomainBaseEntity: Mappable {
    var objectID: NSManagedObjectID?
    
    required init() {
    }
}
