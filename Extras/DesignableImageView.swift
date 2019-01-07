//
//  DesignableImageView.swift
//  GrubShuffle
//
//  Created by Xavier on 1/6/19.
//  Copyright © 2019 Xavier ios dev. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableImageView: UIImageView {
    
//    let imageview = UIImageView()
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = frame.height / 2
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
}
