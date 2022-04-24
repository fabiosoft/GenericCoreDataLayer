//
//  StoryEntity.swift
//  coredata_test
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation
import CoreData


/// This is what a sample StoryEntity looks like.
/// Remember that StoryEntity is a DBEntity, i.e. it can be persisted to the DB.
public class StoryEntity: NSManagedObject {

}

extension StoryEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryEntity> {
        return NSFetchRequest<StoryEntity>(entityName: "StoryEntity")
    }

    @NSManaged public var storyNumber: String?
    @NSManaged public var title: String?

}
