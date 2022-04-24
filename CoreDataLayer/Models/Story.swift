//
//  Story.swift
//  coredata_test
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation
import CoreData

class Story: DomainBaseEntity, Codable {
    // Codable interface is for automatic mapping
    var storyNumber: String?
    var title: String?
}

