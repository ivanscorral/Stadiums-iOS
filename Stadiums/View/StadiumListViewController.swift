//
//  StadiumListViewController.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 9/3/23.
//

import Foundation
import UIKit

class StadiumListViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    /** TODO:
    func fetchData(){
        // Show the activity indicator
        activityIndicator.startAnimating()

        // Fetch the data
        StadiumAPI.fetchStadiums { stadiums in
            // Hide the activity indicator once the data has been loaded
            activityIndicator.stopAnimating()

            // Handle the fetched data as before
            coreDataManager.saveStadiums(stadiums)
            print("Stadiums fetched from API and saved to Core Data:")
            for stadium in stadiums {
                print("ID: \(stadium.id)")
                print("Title: \(stadium.title)")
                print("Geo-coordinates: \(stadium.geocoordinates)")
                print("Image URL: \(stadium.image)")
            }
        }
    } */
}
