//
//  GrubController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/19/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import CoreData


class GrubController {
    
    let fetchResultsController: NSFetchedResultsController<Grub> = {
        //Fetch request
        let fetchRequest: NSFetchRequest<Grub> = Grub.fetchRequest()
        //How i want them sorted
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    //Shared Instance
    static let shared = GrubController()
    
    //Source of Truth
    var grub: [Grub] = []
    
    func fetchAllRestaurants() {
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("Error occurred while fetching data from CoreData: \(error.localizedDescription).")
        }
    }

    
    //MARK: - CRUD Functions
    
    //Create
    func addGrub(categories: String?, imageURLAsString: String?, latitude: Double?, longitude: Double?, name: String, phoneNumber: String?, rating: String?){
        addGrub(categories: categories, imageURLAsString: imageURLAsString, latitude: latitude, longitude: longitude, name: name, phoneNumber: phoneNumber, rating: rating)
        save()
    }
    
    //Update
    
    //Delete
    func delete(grub: Grub){
        grub.managedObjectContext?.delete(grub)
    }
    
    //MARK: CoreDate Persistence
    func save() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
        }
    }
}
