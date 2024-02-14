//
//  CoreDataManager.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import CoreData
import Foundation

/// Main data manager to handle the todo items
class CoreDataManager: NSObject, ObservableObject {
    
    /// Dynamic properties that the UI will react to
    @Published var moviesData: [MoviesData] = [MoviesData]()
    
    /// Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "MoviesData")
    
    /// Default init method. Load the Core Data container
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}

