//
//  SearchCriteriaViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/18/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import CoreLocation
import Lottie

class SearchCriteriaViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var grubLabel: UILabel!
    @IBOutlet weak var keywordsTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var radiusNumberLabel: UILabel!
    @IBOutlet weak var firstDollarSignLabel: UILabel!
    @IBOutlet weak var secondDollarSignLabel: UILabel!
    @IBOutlet weak var thirdDollarSignLabel: UILabel!
    @IBOutlet weak var lastDollarSignLabel: UILabel!
    @IBOutlet weak var openNowSwitch: UISwitch!
    
    //Variables
    var isOpen: Bool?
    //    var locationBoss = CLLocationManager()
    //    var currentLatitude: Double?
    //    var currentLongitude: Double?
    var price: String = "25.0"
    var searchText: String?
    var radiusNumCounter = 1
    let locationManager = LocationManager()
    var latitude: Double?
    var longitude: Double?
    
    private func resetSearch() {
        //        var price = nil
        searchText = nil
        //        radiusNumCounter = nil
        isOpen = nil
        keywordsTextField.text = ""
        keywordsTextField.placeholder = "eg: Pizza, Burgers, Chicken"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceSlider.isContinuous = true
        priceSlider.maximumValue = 100
        priceSlider.minimumValue = 25.0
        locationManager.delegate = self
        locationManager.startLocationUpdates()
        setupTextField()
        setUpContraints()
        
        //        firstDollarSignLabel.textColor = UIColor.green
        radiusLabel.textColor = .black
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetSearch()
        viewDidLayoutSubviews()
        reloadInputViews()
    }
    
    
    func setUpContraints() {
        firstDollarSignLabel.translatesAutoresizingMaskIntoConstraints = false
        secondDollarSignLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdDollarSignLabel.translatesAutoresizingMaskIntoConstraints = false
        lastDollarSignLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Bottom constraints for dollar sign labels
        firstDollarSignLabel.bottomAnchor.constraint(equalTo: priceSlider.topAnchor, constant: -10).isActive = true
        
        secondDollarSignLabel.bottomAnchor.constraint(equalTo: priceSlider.topAnchor, constant: -9).isActive = true
        
        thirdDollarSignLabel.bottomAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: -39).isActive = true
        
        lastDollarSignLabel.bottomAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: -39).isActive = true
        
        
        //Spacing inbetween the dollar saign labels
        firstDollarSignLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33).isActive = true
        //
        //        firstDollarSignLabel.trailingAnchor.constraint(equalTo: secondDollarSignLabel.leadingAnchor, constant: 25).isActive = true
        //
        secondDollarSignLabel.trailingAnchor.constraint(equalTo: thirdDollarSignLabel.leadingAnchor, constant: -86).isActive = true
        
        //        secondDollarSignLabel.leadingAnchor.constraint(equalTo: firstDollarSignLabel.trailingAnchor, constant: 25).isActive = true
        //
        thirdDollarSignLabel.trailingAnchor.constraint(equalTo: lastDollarSignLabel.leadingAnchor, constant: -59).isActive = true
        
        lastDollarSignLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    
    
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    ////        resetSearch()
    //        viewDidLayoutSubviews()
    //        reloadInputViews()
    //    }
    
    
    @IBAction func openNowSwitchValueChanged(_ sender: UISwitch) {
        isOpen = sender.isOn ? true : false
        print("Switch was toggled")
    }
    
    func updateResults(completion: @escaping (Bool) -> Void){
        
        guard let searchText = keywordsTextField.text,
            let currentLatitude = latitude,
            let currentLongitude = longitude
            else { completion(false) ; return }
        YelpObjectController.shared.fetchYelpObject(searchTerm: searchText, latitude: currentLatitude, longitude: currentLongitude, radius: radiusNumCounter) { (success) in
            if success {
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }
    }
    
    //MARK; - Actions
    
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        let loadingView = startLoadingView()
        
        updateResults { (success) in
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "fromSearchToResults", sender: nil)
                }
            } else {
                let status = CLLocationManager.authorizationStatus()
                if ((self.latitude == nil || self.longitude == nil)) {
                    if status != .authorizedWhenInUse && status != .authorizedAlways {
                        self.presentLocationAlert(title: "We can't find any Grub near you!", message: "Please go to settings and enable locations services.", enableSettingsLink: true)
                    } else if status == .denied {
                        self.presentLocationAlert(title: "We can't find any Grub near you!", message: "Please allow us to use your location.", enableSettingsLink: false)
                    } else {
                        self.presentLocationAlert(title: "We can't find any Grub near you!", message: "Please try again.", enableSettingsLink: false)
                    }
                }
            }
            self.stop(loadingView)
        }
        print("tapped")
    }
    
    @IBAction func priceSliderAction(_ sender: UISlider) {
        let fixed = roundf(sender.value / 25) * 25
        priceSlider.setValue(fixed, animated: true)
        
        switch fixed {
        case 25.0:
            price = "1"
            firstDollarSignLabel.textColor = UIColor.green
            //            priceLabel.textColor = Almond
            secondDollarSignLabel.textColor = UIColor.black
            thirdDollarSignLabel.textColor = UIColor.black
            lastDollarSignLabel.textColor = UIColor.black
        case 50.0:
            price = "2"
            firstDollarSignLabel.textColor = UIColor.black
            //            priceLabel.textColor = .green
            secondDollarSignLabel.textColor = UIColor.green
            //             priceLabel.textColor = .green
            thirdDollarSignLabel.textColor = UIColor.black
            //             priceLabel.textColor = .green
            lastDollarSignLabel.textColor = UIColor.black
        //             priceLabel.textColor = .green
        case 75.0:
            price = "3"
            firstDollarSignLabel.textColor = UIColor.black
            secondDollarSignLabel.textColor = UIColor.black
            //            priceLabel.textColor = .purple
            thirdDollarSignLabel.textColor = UIColor.green
            //            priceLabel.textColor = .green
            lastDollarSignLabel.textColor = UIColor.black
            //             priceLabel.textColor = Mustard
            
        case 100.0:
            price = "4"
            //            priceLabel.textColor = .white
            firstDollarSignLabel.textColor = UIColor.black
            secondDollarSignLabel.textColor = UIColor.black
            thirdDollarSignLabel.textColor = UIColor.black
            //             priceLabel.textColor = .purple
            lastDollarSignLabel.textColor = UIColor.green
            //            priceLabel.textColor = Cinnabar
            
        default:
            price = "0"
        }
    }
    
    func changeRadiusLabelColor() {
        if radiusSlider.value != 1 {
            radiusLabel.textColor = Cinnabar
        }else {
            radiusLabel.textColor = .black
        }
    }
    
    @IBAction func radiusSliderAction(_ sender: UISlider) {
        radiusNumberLabel.text = String(Int(sender.value))
        radiusNumCounter = Int(sender.value)
        //        radiusLabel.textColor = .blue
        changeRadiusLabelColor()
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

extension SearchCriteriaViewController : LocationManagerDelegate {
    
    func locationWasUpdated(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func presentLocationAlert(title: String, message: String, enableSettingsLink: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if enableSettingsLink {
            alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { (_) in
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            })
        }
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
}

extension SearchCriteriaViewController: UITextFieldDelegate {
    func setupTextField() {
        keywordsTextField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == keywordsTextField {
            guard let searchTerm = keywordsTextField.text, !searchTerm.isEmpty else { return }
            self.searchText = searchTerm
        }
        keywordsTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == keywordsTextField {
            keywordsTextField.resignFirstResponder()
        }
        return true
    }
}

