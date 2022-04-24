//
//  DBManager.swift
//  coredata_test
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation


/// DBManager to initialize the required DAOs.
/// We need to provide the StorageContext implementation while initializing the DAO classes. StorageContext is the dependency for DBManager and should be set before calling any DAO. Subclass this, and add DAOs as (eventually lazy) properties.
/// The ideal place to provide the StorageContext implementation is at the start of the app. However, it can be changed depending on your needs.
class DBManager {
    
    //lazy var baseDao = BaseDao(storageContext: storageContextImpl())

    private var storageContext: StorageContext?
    
    class var shared: DBManager {
        struct __ { static let _sharedInstance = DBManager() }
        return __._sharedInstance
    }

    static func setup(storageContext: StorageContext) {
        shared.storageContext = storageContext
    }

    public func storageContextImpl() -> StorageContext {
        if self.storageContext != nil {
            return self.storageContext!
        }
        fatalError("You must call setup to configure the StoreContext before accessing any dao")
    }

}
