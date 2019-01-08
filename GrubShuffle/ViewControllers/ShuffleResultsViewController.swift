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
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    
    
    var yelpShuffle: [YelpObjects] = []
    
    var pickerIndexes: [Int] = []
    
    var selectedYelpObject: YelpObjects?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shufflePickerView.delegate = self
        shufflePickerView.dataSource = self
        prepareShuffle()
        viewDetailsButton.isHidden = true
        viewDetailsButton.alpha = 0
    
        let index = shufflePickerView.selectedRow(inComponent: 0)
        let yelpObject = yelpShuffle[index]
        selectedYelpObject = yelpObject
    }

    func prepareShuffle() {
        for index in 0...100 {
            let pickerIndex = index % yelpShuffle.count
            pickerIndexes.append(pickerIndex)
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromShuffleToDetailVC" {
            guard let destinationVC = segue.destination as? GrubDetailViewController else { return }
            destinationVC.yelpObject = selectedYelpObject
            print("break")
        }
    }
    
    
    
    @IBAction func ShuffleButtonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1) {
            self.viewDetailsButton.alpha = 0
        }
        viewDetailsButton.isHidden = true
        
        var shuffledSelection = selectedYelpObject
        var randomIndex = Int.random(in: 0...100)
        // While the selection matches previous selection, keep randomizing
        while shuffledSelection == selectedYelpObject {
            randomIndex = Int.random(in: 0...100)
            shuffledSelection = yelpShuffle[pickerIndexes[randomIndex]]
        }

        shufflePickerView.selectRow(randomIndex, inComponent: 0, animated: true)
        shufflePickerView.showsSelectionIndicator = true
        selectedYelpObject = shuffledSelection
        UIView.animate(withDuration: 20, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //Increase button
//            self.shuffleButton.bounds.size.width += 10
        }) { (finished) in
            UIView.animate(withDuration: 20, delay: 0.0, options: .curveEaseOut, animations: {
                //decrease button
                
//                self.shuffleButton.bounds.size.width -= 10
                print("Shuffle button tapped")
            }, completion: nil)
        }
        
        viewDetailsButton.isHidden = false
        UIView.animate(withDuration: 1) {
            self.viewDetailsButton.alpha = 1
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
        return pickerIndexes.count
    }
//
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedIndex = pickerIndexes[row]
        let yelpObject = yelpShuffle[selectedIndex]
        selectedYelpObject = yelpObject
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let chosenIndex = pickerIndexes[row]
        return yelpShuffle[chosenIndex].name
    }
}
