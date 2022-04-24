//
//  StoryService.swift
//  coredata_test
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation

class StoryService {

    func createStory(story: Story) {
        do {
            try StoryDBManager.shared.storyDao.save(object: story)
        } catch let err{
            fatalError(err.localizedDescription)
        }
    }
    
    func fetchStoryByStoryNumber(storyNumber: String) -> Story? {
        return StoryDBManager.shared.storyDao.findById(storyNumber: storyNumber)
    }
    
    @discardableResult
    func deleteAll() -> Bool{
        do{
            try StoryDBManager.shared.storyDao.deleteAll()
            return true
        }catch{
            return false
        }
    }
    @discardableResult
    func delete(story: Story) -> Bool{
        do{
            try StoryDBManager.shared.storyDao.delete(object: story)
            return true
        }catch{
            return false
        }
    }
    
}
