//
//  CoredataStack.swift
//  CoreDataSample
//
//  Created by sbyka on 27/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit
import CoreData

class CoredataStack: NSObject {

    
    static let shared: CoredataStack = CoredataStack()
    
//    private override init() {
//        
//    }
    
    
    var studentList:[Students] = []
    
    // MARK: Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataSample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        })
        return container
    }()
    
    //MARK: - Core Data Saving support
    
    func saveContext() {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
              try context.save()
            }catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
        }
        
    }
    
    
}

