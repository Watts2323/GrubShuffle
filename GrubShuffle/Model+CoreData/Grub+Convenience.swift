//
//  Grub+Convenience.swift
//  GrubShuffle
//
//  Created by Xavier on 12/18/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation
import CoreData
import Contacts
import CoreLocation
import MapKit

extension Grub {
    
    convenience init(categories: String?, imageURLAsString: String?, isFavorited: Bool = true, latitude: Double?, longitude: Double?, name: String, phoneNumber: String?, rating: String?, title: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        
        self.init(context: context)
        
        self.categories = categories
        self.imageURLAsString = imageURLAsString
        self.isFavorited = isFavorited
        //Have to unwrap Longitude and Latitude because when I didn't it threw me an Error
        guard let latitude = latitude, let longitude = longitude else { return }
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.phoneNumber = phoneNumber
        self.rating = rating
        self.title = title
    }
}
