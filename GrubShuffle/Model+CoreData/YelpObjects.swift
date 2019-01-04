//
//  yelpObjects.swift
//  GrubShuffle
//
//  Created by Xavier on 12/31/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation

struct YelpObjects: Decodable {
    var categories: Categories
    var imageURLAsString: String?
    var isFavorited: Bool?
    var name: String
    var phoneNumber: String
    var rating: Int?
//    var location: Location
//    var imageURL: URL? {
//        if let urlString = imageURLAsString {
//            return URL(string: urlString)
//        } else {
//            return nil
//        }
//    }
    
    enum CodingKeys: String, CodingKey {
        case categories
        case imageURLAsString = "image_url"
        case isFavorited
        case name
        case phoneNumber = "phone"
        case rating
    }
}
struct Categories: Decodable {
    var titles: [Titles]
}
struct Titles: Decodable {
    var title: String
}
struct Coordinates: Decodable {
    var latitude: Double?
    var longitude: Double?
}
struct Location: Decodable {
    var displayAddress: [String]
    
    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
    }
}
