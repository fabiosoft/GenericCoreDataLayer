//
//  StoryDBManager.swift
//  coredata_test
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation

class StoryDBManager : DBManager {
    lazy var storyDao = StoryDao(storageContext: storageContextImpl())
//    lazy var anyOtherDao = AnyOtherDao(storageContext: storageContextImpl())

    override class var shared: StoryDBManager {
        struct __ { static let _sharedInstance = StoryDBManager() }
        return __._sharedInstance
    }
    
    override func storageContextImpl() -> StorageContext {
        return super.storageContextImpl()
    }
}
