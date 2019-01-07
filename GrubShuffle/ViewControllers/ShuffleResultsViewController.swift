//
//  ShuffleResultsViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 1/6/19.
//  Copyright © 2019 Xavier ios dev. All rights reserved.
//

import UIKit

class ShuffleResultsViewController: UIViewController {

    @IBOutlet weak var shufflePickerView: UIPickerView!
    
    var yelpShuffle: [YelpObjects] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shufflePickerView.delegate = self
        shufflePickerView.dataSource = self
        
        for _ in 0...100 {
            var index = 0
            
            if index == yelpShuffle.count {
                index = 0
            }
            
            yelpShuffle.append(yelpShuffle[index])
            index += 1
        }
    }
    
//    func randomGrub(num: Int) -> Int {
//        return Int(arc4random_uniform(UInt32(num)))
//    }
    
    func spinPicker() {
       let pickRandom = Int(arc4random_uniform(89) + 10)
        
        shufflePickerView.selectRow(pickRandom, inComponent: 0, animated: true)
        shufflePickerView.showsSelectionIndicator = true
        
        if pickRandom == 50 || pickRandom == 75 || pickRandom == 90 || pickRandom == 35 {
            
        }
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

extension ShuffleResultsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return YelpObjectController.shared.yelpObjects.count
    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        <#code#>
//    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\( yelpShuffle[row])"
    }

    
}
