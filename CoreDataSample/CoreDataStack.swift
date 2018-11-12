//
//  CoreDataStack.swift
//  CoreDataSample
//
//  Created by sbyka on 06/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import Foundation
import CoreData

func createMainContext() -> NSManagedObjectContext {
    
    // Initialize NSManagedObjectModel
    
    let modelURL = Bundle.main.url(forResource: "CoreDataSample", withExtension: "momd")
    guard let model = NSManagedObjectModel(contentsOf: modelURL!) else {
        fatalError("model not found")
    }

    // Configure NSPersistentStoreCoordinator with an NSPersistantStore
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    
    let storeURL = URL.documentURL.appendingPathComponent("CoreDataSample.sqlite")
        
        
        //try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("CoreDataSample.sqlite")
    
    //TODO Use migrations!
    try! FileManager.default.removeItem(at: storeURL)
    
    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
 
    // Create and return NSManagedObjectContext
    
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
    
    
    
}


extension URL {
    static var documentURL: URL {
        return try! FileManager
        .default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}


protocol ManagedObjectContextDependentType {
    var managedObjectContext : NSManagedObjectContext! {get set}
    
}
