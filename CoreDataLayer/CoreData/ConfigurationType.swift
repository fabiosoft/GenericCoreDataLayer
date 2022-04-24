//
//  ConfigurationType.swift
//  coredata
//
//  Created by Fabio Nisci on 20/04/22.
//

import Foundation


/// The most common databases come with both a concrete and an in-memory implementation. Core Data has an in-memory type that can be used for unit testing. Enum ConfigurationType supports this need.
public enum ConfigurationType {
    case basic(identifier: String)
    case inMemory(identifier: String?)

    func identifier() -> String? {
        switch self {
        case .basic(let identifier): return identifier
        case .inMemory(let identifier): return identifier
        }
    }
}
