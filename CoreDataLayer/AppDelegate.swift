//
//  AppDelegate.swift
//  CoreDataLayer
//
//  Created by Fabio Nisci on 24/04/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        StoryDBManager.setup(storageContext: CoreDataStorageContext(configuration: .basic(identifier: "CoreDataLayer")))
        
        return true
    }

}

