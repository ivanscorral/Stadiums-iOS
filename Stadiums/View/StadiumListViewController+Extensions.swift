//
//  StadiumListViewController+Extensions.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 10/3/23.
//

import UIKit
import Foundation


	
extension StadiumListViewController: UISearchBarDelegate {

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterStadiums(searchText)
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelButtonTapped()
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
                self?.stadiums.removeAll()
                self?.stadiums.append(contentsOf: stadiums)
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


    
