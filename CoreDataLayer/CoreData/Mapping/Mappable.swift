//
//  Mappable.swift
//  coredata_test
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation
import CoreData



/// All our domain entities should implement the Mappable protocol.
///
/// Domain entities and database entities should be different.
/// View controllers and the business (service) layer should not know about the database entities; the view controller should not know what a NSManagedObject is.
protocol Mappable {
    var objectID: NSManagedObjectID? { get set } //You may not need it if you already have a custom ID for your entities, such as story number.
    init()
}
