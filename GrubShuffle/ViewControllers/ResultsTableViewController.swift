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
//    var address: [Location] = []
    
    var resultsArray: [YelpObjects] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    @IBAction func NextButtonTapped(_ sender: Any) {
        print("Next Button Tapped")
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YelpObjectController.shared.yelpObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath)
        
        let yelpGrubs = YelpObjectController.shared.yelpObjects[indexPath.row]
        let addie = yelpGrubs.location
        cell.textLabel?.text = yelpGrubs.name
        cell.detailTextLabel?.text = "\(addie.displayAddress)".stripped

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            
            guard let index = resultsArray.index(of: YelpObjectController.shared.yelpObjects[indexPath.row]) else { return }
            resultsArray.remove(at: index)
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            resultsArray.append(YelpObjectController.shared.yelpObjects[indexPath.row])
        }
    }

//     MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromResultsToShuffle" {
            guard let destinationVC = segue.destination as? ShuffleResultsViewController,
                let _ = tableView.indexPathForSelectedRow else { return }
            
            destinationVC.yelpShuffle = resultsArray
        }
    }

}
