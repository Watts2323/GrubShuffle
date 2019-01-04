//
//  LastOnboadingViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/30/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import Lottie

class LastOnboadingViewController: UIViewController {
    
    @IBOutlet weak var animationView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toMainVC", sender: self)
    }
    
    func startAnimation(){
        animationView.setAnimation(named: "noodles")
        animationView.play()
        animationView.loopAnimation = true
    }
}

//let status = CLLocationManager.authorizationStatus()
//if ((latitude == nil || longitude == nil)) {
//    if status != .authorizedWhenInUse && status != .authorizedAlways {
//        presentLocationAlert(title: "We can't find any Grub near you!", message: "Please go to settings and enable locations services.", enableSettingsLink: true)
//    } else if status == .denied {
//        presentLocationAlert(title: "We can't find any Grub near you!", message: "Please allow us to use your location.", enableSettingsLink: false)
//    } else {
//        presentLocationAlert(title: "We can't find any Grub near you!", message: "Please try again.", enableSettingsLink: false)
//    }
//}
