//
//  LoadingScreenViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/29/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import Lottie

class LoadingScreenViewController: UIViewController {

    @IBOutlet weak var customView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        present(self, animated: true) {
//            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
//                
//            })
//        }
//    }
//    
    
    
    func startAnimation() {
        customView.setAnimation(named: "data")
        customView.play()
        customView.loopAnimation = true
    }
}
