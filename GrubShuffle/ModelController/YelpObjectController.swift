//
//  YelpObjectController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/31/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit


class YelpObjectController {
    
    let baseURL = URL(string: "https://api.yelp.com/v3/businesses")
    
    static let shared = YelpObjectController()
    
    var yelpObjects: [YelpObjects] = []
    
    
    func fetchYelpObject(searchTerm: String, latitude: Double, longitude: Double, radius: Int, completion: @escaping (Bool) -> Void) {
        
        // Unwrap the baseURL
        guard let baseURL = baseURL else { completion(false) ; return }
        let fullSearchURL = baseURL.appendingPathComponent("search", isDirectory: false)
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let latitudeQueryItem = URLQueryItem(name: "latitude", value: "\(latitude)")
        let longitudeQueryItem = URLQueryItem(name: "longitude", value: "\(longitude)")
        let radiusQueryItem = URLQueryItem(name: "radius", value: "\(radius * 100)")
        
        var components = URLComponents(url: fullSearchURL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [searchTermQueryItem, latitudeQueryItem, longitudeQueryItem, radiusQueryItem]
        
        guard let requestURL = components?.url else { completion(false) ; return }
        
        var urlRequest = URLRequest(url: requestURL)
        // This is where we add the header
//        urlRequest.setValue("Header", forHTTPHeaderField: "Bearer d9M2bBoEX5xzCDK0esUf9G69S8JNGQL9ybYSU5IavgAOjxAnVwauMUj5ln8OHyeL48gFN99dtGexeQn69voYTzBU3kYv1pu2yc5wlJExRMZmlfJ8iPLMgyKA3dYaXHYxpost")
        
        urlRequest.setValue("Bearer d9M2bBoEX5xzCDK0esUf9G69S8JNGQL9ybYSU5IavgAOjxAnVwauMUj5ln8OHyeL48gFN99dtGexeQn69voYTzBU3kYv1pu2yc5wlJExRMZmlfJ8iPLMgyKA3dYaXHYx", forHTTPHeaderField: "Authorization")
        
        // datatask
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion(false);return
            }
            guard let data = data else { completion(false); return}
            let decoder = JSONDecoder()
            //Decode here
            do {
                let yelpObjects = try decoder.decode(TopLevelJSON.self, from: data)
                self.yelpObjects = yelpObjects.businesses
                completion(true)
            } catch{
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion(false);return
            }
            }.resume()
    }
    
    func getYelpImage(for yelpObject: YelpObjects, completion: @escaping (UIImage?) -> Void){
        
        guard let imageURLAsString = yelpObject.imageURLAsString else { return }
        //construct URL
        guard let url = URL(string: imageURLAsString)  else { completion(nil); return }
        
        //DataTask
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion(nil);return
            }
            guard let data = data else { completion(nil); return }
            let image = UIImage(data: data)
            completion(image)
            }.resume()
    }
}
