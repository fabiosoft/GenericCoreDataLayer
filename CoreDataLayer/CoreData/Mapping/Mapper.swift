//
//  Mapper.swift
//  coredata_test
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation
import CoreData
/// I used the Runtime library for iterating over the properties and copying them from the domain entity to a DB entity and vice versa.
import Runtime


/// Mapper, which maps the entities from domain to DB and vice versa.
class Mapper {

    class func mapToDomain<DBEntity: Storable, DomainEntity: Mappable>(from dbEntity: DBEntity, target domainEntity: inout DomainEntity) {

        let domainEntityInfo = try? typeInfo(of: DomainEntity.self)
        let managedObject: NSManagedObject? = dbEntity as? NSManagedObject
        let keys = managedObject?.entity.attributesByName.keys

        for dbEntityKey in keys! {
            let value = managedObject?.value(forKey: dbEntityKey)
            do {
                let domainProperty = try domainEntityInfo?.property(named: dbEntityKey)
                try domainProperty?.set(value: value as Any, on: &domainEntity)
            } catch {
                print(error.localizedDescription)
            }
        }
        domainEntity.objectID = managedObject?.objectID
    }

    class func mapToDB<DomainEntity: Mappable, DBEntity: Storable>(from domainEntity: DomainEntity, target dbEntity: DBEntity) {

        let managedObject: NSManagedObject? = dbEntity as? NSManagedObject
        let keys = managedObject?.entity.attributesByName.keys

        let domainEntityMirror = Mirror(reflecting: domainEntity)
        for dbEntityKey in keys! {
            for property in domainEntityMirror.children.enumerated() where
                property.element.label == dbEntityKey {
                    let value = property.element.value as AnyObject
                    if !value.isKind(of: NSNull.self) {
                        managedObject?.setValue(value, forKey: dbEntityKey)
                    }
            }
        }
    }
}
