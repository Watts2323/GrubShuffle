//
//  extentsion.swift
//  GrubShuffle
//
//  Created by Xavier on 12/20/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import Lottie

extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = self.size.width / self.size.height
        return widthRatio
    }
}

extension String {
    
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return self.filter {okayChars.contains($0) }
    }
    
}

extension UIViewController {
    
    func startLoadingView() -> LOTAnimationView {
        let loadingView = LOTAnimationView(frame: .zero)
        loadingView.setAnimation(named: "data")
        loadingView.loopAnimation = true
        loadingView.play()
        
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            loadingView.heightAnchor.constraint(equalTo: loadingView.widthAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        return loadingView
    }
    
    func stop(_ loadingView: LOTAnimationView) {
        
        loadingView.stop()
        loadingView.removeFromSuperview()
    }
}
