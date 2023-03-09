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
    
    let viewModel = StadiumListViewModel()
    var stadiums: [Stadium] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom cell
        tableView.register(UINib(nibName: "StadiumTableViewCell", bundle: nil), forCellReuseIdentifier: "StadiumTableViewCell")
        
        // Set up table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set up searchbar delegate
        searchBar.delegate = self

        
        // Bind view model closures
        viewModel.stadiumsDidChange = { [weak self] result in
            switch result {
            case .success(let stadiums):
                self?.stadiums.removeAll()
                self?.stadiums.append(contentsOf: stadiums)
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch stadiums: \(error.localizedDescription)")
                // Show error message to user
            }
        }

        viewModel.errorDidChange = { [weak self] error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                // Show error message to user
            } else {
                print("No error.")
            }
        }
        
        // Fetch stadiums from API or Core Data
        viewModel.fetchStadiums()
        
        // Set up gesture recognizer to dismiss keyboard on tap outside of search bar
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}

extension StadiumListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stadiums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StadiumTableViewCell", for: indexPath) as! StadiumTableViewCell
        
        cell.stadium = stadiums[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Handle stadium selection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

extension StadiumListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterStadiums(searchText)
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        viewModel.filterStadiums("")
    }
    
}

extension StadiumListViewController: UIGestureRecognizerDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
