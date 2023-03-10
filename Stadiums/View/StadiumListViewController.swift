//
//  StadiumListViewController.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 9/3/23.
//
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
        // Disable the tap recognizer on the table view
        tableView.allowsSelection = true
        tableView.allowsSelectionDuringEditing = true
        tableView.allowsMultipleSelection = false
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.delaysContentTouches = false
        tableView.canCancelContentTouches = true
        tableView.panGestureRecognizer.isEnabled = true


        // Add tap gesture recognizer to dismiss keyboard on tap outside of search bar
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

        // Add tap gesture recognizer to the navigation bar
        let navBarTapGesture = UITapGestureRecognizer(target: self, action: #selector(titleViewTapped))
        navigationItem.titleView?.addGestureRecognizer(navBarTapGesture)
        navigationItem.titleView?.isUserInteractionEnabled = true
        // Set up navigation controller
        title = "Stadiums"

        // Bind view model closures
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

        viewModel.errorDidChange = { [weak self] error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self?.showErrorAlert(withMessage: error.localizedDescription)
            } else {
                print("No error.")
            }
        }

        // Fetch stadiums from API or Core Data
        viewModel.fetchStadiums()
    }

    @objc fileprivate func titleViewTapped() {
        // Scroll the table view up animatedly
        tableView.setContentOffset(CGPoint.zero, animated: true)
    }
}

extension StadiumListViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stadiums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StadiumTableViewCell", for: indexPath) as? StadiumTableViewCell else {
            fatalError("Failed to dequeue StadiumTableViewCell.")
        }
        
        cell.stadium = stadiums[indexPath.row]
        
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nib = UINib(nibName: "StadiumDetailsViewController", bundle: nil)
        let stadiumDetailsVC = nib.instantiate(withOwner: nil, options: nil).first as! StadiumDetailsViewController
        stadiumDetailsVC.stadium = stadiums[indexPath.row]
        navigationController?.pushViewController(stadiumDetailsVC, animated: true)

    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92.0
    }
}
