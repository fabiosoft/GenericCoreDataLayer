//
//  StoryDao.swift
//  coredata_test
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation


/// This is a specific StoryDao which subclasses the BaseDao.
///
///  Every subclass of BaseDao should provide the Domain and DB entity. In the case of StoryDao the Domain entity is Story and the DBentity is StoryEntity. I prefer to create a different DAO for every entity/database table.
class StoryDao: BaseDao<Story, StoryEntity> {

    func findById(storyNumber: String) -> Story? {
//        SQLite stores being incompatible with block predicates, since Core Data cannot translate these to SQL to run them in the store
//        let storyNumberPredicate = NSPredicate { story, _ in
//            guard let story = story as? Story else {
//                return false
//            }
//            return story.storyNumber == storyNumber
//        }
        let storyNumberPredicate = NSPredicate(format: "storyNumber == %@", storyNumber)
        //return super.fetch(predicate: NSPredicate(format: "storyNumber = %"+storyNumber)).last
        return super.fetch(predicate: storyNumberPredicate).last
    }
}
