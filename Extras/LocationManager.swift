//
//  locationManager.swift
//  GrubShuffle
//
//  Created by Xavier on 12/21/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol LocationManagerDelegate: class {
    func locationWasUpdated(latitude: Double, longitude: Double)
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    // MARK: - Properties
    weak var delegate: LocationManagerDelegate?
    
    func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
    //This fires off everytime the user location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        print(location.coordinate.latitude)
        let latitude = Double(location.coordinate.latitude)
        let longitude = Double(location.coordinate.longitude)
        delegate?.locationWasUpdated(latitude: latitude, longitude: longitude)
        print(latitude)
        
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapkitView.setRegion(region, animated: true)
    }
    
    //After it checks for the location authorization it runs the switch statement
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle Error
        print("adsf")
    }
}

extension GrubDetailViewController: MKMapViewDelegate {
    
}
