//
//  CoreDataProvider.swift
//  capstone
//
//  Created by Sama Durani on 10/23/24.
//

import Foundation
import CoreData

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        
        // register transformers
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores{ description, error in
            if let error {
                fatalError("Error initializing RemindersModel \(error)")
            }
            
        }
    }
}
