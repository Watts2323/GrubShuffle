//
//  ChoosePlaceOnboardingViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/30/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import Lottie

class ChoosePlaceOnboardingViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var animationView: LOTAnimationView!
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }
    //MARK: ACTIONS
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        sender.removeFromSuperview()
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "grubShuffleMainVC") {
            present(mainVC, animated: true, completion: nil)
        }
    }
    
    func startAnimation(){
        animationView.setAnimation(named: "building_evolution_animation")
        animationView.play()
        animationView.loopAnimation = true
    }

}
