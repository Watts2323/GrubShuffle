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

class MapkitViewController: UIViewController, MKMapViewDelegate{
    
    var yelpObject: YelpObject? {
        didSet{
            updateMapView()
        }
    }
    
    //Variables:
    let locationManger = CLLocationManager()
    let regionInMeters: Double = 15000
    let geoCoder = CLGeocoder()
    
    
    @IBOutlet weak var mapKitView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 240/255, blue: 203/255, alpha: 1)
        updateMapView()
    }
    
    func updateMapView() {
        guard let mapKitView = mapKitView else { return }
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(40.761882, -111.890761)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        mapKitView.setRegion(region, animated: true)
        guard let yelpObject = yelpObject else { return }
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = yelpObject.name
        annotation.subtitle = "\(String(describing: yelpObject.location.displayAddress))".stripped
        mapKitView.addAnnotation(annotation)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let annotation = annotation
//
//        let identifier = "marker"
//        var markerView: MKMarkerAnnotationView
//
//        if let viewRecycled = mapKitView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
//            viewRecycled.annotation = annotation
//            markerView = viewRecycled
//        } else {
//            markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            markerView.canShowCallout = true
//            markerView.calloutOffset = CGPoint(x: -5, y: 5)
//            let markerButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50)))
//            markerButton.setTitle("Driving Directions", for: .normal)
//            markerView.rightCalloutAccessoryView = markerButton
//        }
//        return markerView
//    }
//
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        var myLocation = view.annotation
//        let mapItem = MKMapItem()
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
//        myLocation? = mapItem.openInMaps(launchOptions: launchOptions) as! MKAnnotation
//    }
    
   
    
    @IBAction func backToSearchButtonTapped(_ sender: UIButton) {
        let Searchvc = UIViewController()
        self.navigationController?.popToViewController(Searchvc, animated: true)
        print("Was hit")
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

//extension MapkitViewController: MKMapViewDelegate {
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let annotation = annotation
//
//        let identifier = "marker"
//        var markerView: MKMarkerAnnotationView
//
//        if let viewRecycled = mapKitView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
//            viewRecycled.annotation = annotation
//            markerView = viewRecycled
//        } else {
//            markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            markerView.canShowCallout = true
//            markerView.calloutOffset = CGPoint(x: -5, y: 5)
//            let markerButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50)))
//            markerButton.setTitle("Driving Directions", for: .normal)
//            markerView.rightCalloutAccessoryView = markerButton
//        }
//        return markerView
//    }
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        let markerLocations = view.annotation as? YelpObject
////        let mapItem: MKMapItem
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
////        markerLocations.map
//    }
//}
