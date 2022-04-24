//
//  Storable.swift
//  coredata
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation
import CoreData


/// Any entity that needs to be saved to the database should implement the Storable protocol.
public protocol Storable {
    init()
}

/// All Core Data entities inherit the NSManagedObject, and by default, NSManagedObject does not implement the Storable protocol. To mark the NSManagedObject as storable we need to conform it to theStorable
extension NSManagedObject: Storable {
}
