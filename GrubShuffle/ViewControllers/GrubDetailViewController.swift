//
//  GrubDetailViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/21/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GrubDetailViewController: UIViewController {
    
    //Variables:
    let locationManger = CLLocationManager()
    let regionInMeters: Double = 10000

    //MARK: OUTLETS
    @IBOutlet weak var mapkitView: MKMapView!
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var oneStarRating: UIImageView!
    @IBOutlet weak var twoStarRating: UIImageView!
    @IBOutlet weak var threeStarRating: UIImageView!
    @IBOutlet weak var fourStarRating: UIImageView!
    @IBOutlet weak var fiveStarRating: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Made mapkitView the delegate in the storyboard
        checkLocationServices()
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
            mapkitView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
//just means only use their loaction when they are using the app
        case .authorizedWhenInUse:
            mapkitView.showsUserLocation = true
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
