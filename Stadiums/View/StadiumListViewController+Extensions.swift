//
//  StadiumListViewController+Extensions.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 10/3/23.
//

import UIKit
import Foundation


	
// MARK: - UISearchBarDelegate

extension StadiumListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterStadiums(searchText)
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filterStadiums("")
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}

// MARK: - UITableViewDelegate

extension StadiumListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let stadiumDetailsVC = storyboard.instantiateViewController(withIdentifier: "StadiumDetailsViewController") as! StadiumDetailsViewController
        stadiumDetailsVC.stadium = filteredStadiums[indexPath.row]
        navigationController?.pushViewController(stadiumDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92.0
    }
}


extension StadiumListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStadiums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StadiumTableViewCell", for: indexPath) as? StadiumTableViewCell else {
            fatalError("Failed to dequeue StadiumTableViewCell.")
        }
        
        cell.stadium = filteredStadiums[indexPath.row]
        
        return cell
    }
}


extension StadiumListViewController: UIGestureRecognizerDelegate {

    // MARK: - UIGestureRecognizerDelegate

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
}

extension StadiumListViewController {

    // MARK: - Private methods

    func showErrorAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension StadiumListViewController {

    // MARK: - ViewModel bindings

    func bindViewModel() {

        // Bind stadiumsDidChange closure
        viewModel.stadiumsDidChange = { [weak self] result in
            switch result {
            case .success(let stadiums):
                self?.allStadiums = stadiums
                self?.filteredStadiums = stadiums
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch stadiums: \(error.localizedDescription)")
                self?.showErrorAlert(withMessage: error.localizedDescription)
            }
        }

        // Bind errorDidChange closure
        viewModel.errorDidChange = { [weak self] error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self?.showErrorAlert(withMessage: error.localizedDescription)
            } else {
                print("No error.")
            }
        }
    }


    // MARK: - Fetch stadiums

    func fetchStadiums() {
        viewModel.fetchStadiums()
    }
    
    // MARK: - Filter stadiums

    func filterStadiums(_ searchText: String) {
        viewModel.filterStadiums(searchText)
        tableView.reloadData()
    }

    // MARK: - Dismiss keyboard

    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }

    // MARK: - Cancel button tapped

    func cancelButtonTapped() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filterStadiums("")
    }
}


    
