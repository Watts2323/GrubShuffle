//
//  WelcomeOnboardingViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/30/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import Lottie

class WelcomeOnboardingViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        sender.removeFromSuperview()
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "grubShuffleMainVC") {
            present(mainVC, animated: true, completion: nil)
        }
    }
}
