//
//  CoreDataStack.swift
//  GrubShuffle
//
//  Created by Xavier on 12/18/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation
import CoreData

//Dont want to initialize the stack so make it an enum

enum CoreDataStack {
    
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "GrubShuffle")
        //Its smart enough to check if there is already a persistent store then it will load that
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error{
                fatalError("Failed to Load Data from Persistent Store \(error)\(String(describing: error._userInfo))")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
