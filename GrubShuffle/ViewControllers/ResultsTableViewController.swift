//
//  ResultsTableViewController.swift
//  GrubShuffle
//
//  Created by Xavier on 1/1/19.
//  Copyright © 2019 Xavier ios dev. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var yelpGrubObjects: [YelpObjects] = []
    var currentLatitude: Double?
    var currentLongitude: Double?
    var price: String?
    var searchText: String?
    var radiusNumCounter: Int?
    var address: [Location] = []
    
    let resultsArray: [YelpObjects] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YelpObjectController.shared.yelpObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath)
        
        let yelpGrubs = yelpGrubObjects[indexPath.row]
        let addie = address[indexPath.row]
        cell.textLabel?.text = yelpGrubs.name
        cell.detailTextLabel?.text = "\(addie.displayAddress)"

        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
