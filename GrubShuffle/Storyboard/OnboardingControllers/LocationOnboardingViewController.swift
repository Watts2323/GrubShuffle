//
//  LocationOnboardingViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/30/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import Lottie
import CoreLocation

class LocationOnboardingViewController: UIViewController {

    @IBOutlet weak var animationView: LOTAnimationView!
    @IBOutlet weak var continueButton: UIButton!
    
     let locationManager = CLLocationManager()
      let regionInMeters:Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        checkLocationServices()
    }
    
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        sender.removeFromSuperview()
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "grubShuffleMainVC") {
            present(mainVC, animated: true, completion: nil)
        }
    }
    
    func startAnimation(){
        animationView.setAnimation(named: "search")
        animationView.play()
        animationView.loopAnimation = true
    }
}

extension LocationOnboardingViewController {
    func setUpLocationManager() {
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {  //2nd) We check the user device wide location in the setting of the device. So if that is enabled then we are good to go and setUpLocationManager and based on that we checkLocationAuthorization
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationAuthorization()
        } else {
            //show alert letting thre user know they have to turn this on.
            presentLocationAlert(title: "Location services are Disabled", message: "Please go to settings and enable!", enableSettingsLink: true)
        }
    }
    
    //When do we call checkLocationAuthorization is after we check like 2 to see if location services is enabled or disabled
    
    func checkLocationAuthorization() {  //3rd) We check our cases, have authorization been denied, restricted, determined and act accordingly.
        switch CLLocationManager.authorizationStatus(){
            
        case .notDetermined:
            //If i's not determined then we ask for permission.
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //Show an alert letting them know whats going on.
            presentLocationAlert(title: "Location Restricted", message: "The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.", enableSettingsLink: true)
            break
        //Not authorized to use location services, parental control, or other restrictions
        case .denied:
            //show alert instructing how to turn on in permission becausae once they deny you you cant ask them again
            presentLocationAlert(title: "Permission to use location Denied", message: "Permission to use location was denied. Please got to settings to grant permission.", enableSettingsLink: true)
            
        //This always gets the users location even when the app is closed. With this one be sensitive to the user privacy.
        case .authorizedAlways:
            break
        //This gets the user location when the app is open or in use.
        case .authorizedWhenInUse:
            startTrackingUserLocation()
            //            MapView.showsUserLocation = true
        }
    }
    
    func startTrackingUserLocation() {
        //All of this code was in the authorizeWhenInUse case but to make it more readable and not so cluttered I created it's own function
        locationManager.startUpdatingLocation()
    }
    
    func presentLocationAlert(title: String, message: String, enableSettingsLink: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if enableSettingsLink {
            alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { (_) in
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            })
        }
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
}
