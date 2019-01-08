//
//  MapkitViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 1/4/19.
//  Copyright © 2019 Xavier ios dev. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapkitViewController: UIViewController {
    
    var yelpMap: YelpObjects? {
        didSet{
            
        }
    }
    
    //Variables:
    let locationManger = CLLocationManager()
    let regionInMeters: Double = 10000
    
    @IBOutlet weak var mapKitView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
//        navigationController?.navigationBar.barTintColor = UIColor.blue
    }
    @IBAction func backToSearchButtonTapped(_ sender: UIButton) {
        
    }
    
    func setUpLocationManager(){
        locationManger.delegate = self as? CLLocationManagerDelegate
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationAuthorization()
        }else{
            //Alert goes here explaing why we need their location
        }
    }
    
    func centerViewOnUsersLocation() {
        if let location = locationManger.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            guard let mapkitV = mapKitView else { return }
            mapKitView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        //just means only use their loaction when they are using the app
        case .authorizedWhenInUse:
//            mapKitView.showsUserLocation = true
            centerViewOnUsersLocation()
            //Line 67 fires off the didUpdate Function in the location Manager File
            locationManger.startUpdatingLocation()
        //They denied permisson so the only way they we can get their location is if they go to settings and allow us to.
        case .denied:
            break
        //Request permission
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        //Always use their location even when they don't have the app open
        case .authorizedAlways:
            break
        //Parentol control stuff
        case .restricted:
            //show an alert telling them it's been restricted
            break
        }
    }
    
}
