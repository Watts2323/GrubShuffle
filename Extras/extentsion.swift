//
//  extentsion.swift
//  GrubShuffle
//
//  Created by Xavier on 12/20/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

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
