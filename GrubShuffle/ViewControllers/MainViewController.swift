//
//  MainViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/17/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import Lottie

class MainViewController: UIViewController {

    @IBOutlet weak var animationView: LOTAnimationView!
    @IBOutlet weak var getMyLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }
    
    //Mark: - Actions
    @IBAction func GetMyLocationButtonTapped(_ sender: UIButton) {
        
    }
    
    func startAnimation(){
        animationView.setAnimation(named: "plate")
        animationView.play()
        animationView.loopAnimation = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
