//
//  GrubDetailViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 12/21/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
//import MapKit
//import CoreLocation

class GrubDetailViewController: UIViewController {
    
    var yelpObject: YelpObject? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    //    var grub: Grub? {
    //        didSet{
    //            showImage()
    //        }
    //    }
    
    //MARK: OUTLETS
    
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var oneStarRating: UIImageView!
    @IBOutlet weak var twoStarRating: UIImageView!
    @IBOutlet weak var threeStarRating: UIImageView!
    @IBOutlet weak var fourStarRating: UIImageView!
    @IBOutlet weak var fiveStarRating: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UIButton!
    @IBOutlet weak var plainView: UIView!
    @IBOutlet weak var mapButton: UIButton!
    
    func updateViews() {
        guard let yelpObject = yelpObject else { return }
        nameLabel.text = yelpObject.name.stripped
        addressLabel.text = "\(yelpObject.location.displayAddress)".stripped
        categoriesLabel.text = yelpObject.categoriesString
        
        let phoneNumber = PhoneNumberFormatter.formatPhoneNumber(yelpObject.phoneNumber)
        phoneNumberLabel.setTitle(phoneNumber, for: .normal)
    }
    
    func showImage(){
        guard let yelpImageObject = yelpObject else { return }
        picImageView.layer.cornerRadius = picImageView.layer.frame.height / 2
        YelpObjectController.shared.getYelpImage(for: yelpImageObject ) { (image) in
            DispatchQueue.main.async {
                self.picImageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        checkLocationServices()
        updateViews()
        showImage()
                  navigationController?.navigationBar.barTintColor = Cinnabar
    }
    
    @IBAction func phoneNumberButtonTapped(_ sender: UIButton) {
        guard let yelpObject = yelpObject else { return }
        let phoneNumber = yelpObject.phoneNumber
        
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else {
                print("Bad Phone number")
            }
        }
    }
    
    @IBAction func mapButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "fromDetailToMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromDetailToMap" {
            guard let destinationVC = segue.destination as? MapkitViewController else { return }
            destinationVC.yelpObject = yelpObject
        }
    }
}
