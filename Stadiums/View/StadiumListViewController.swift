//
//  StadiumListViewController.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 9/3/23.
//

import UIKit

class StadiumListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

     let viewModel = StadiumListViewModel()
     var stadiums: [Stadium] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        viewModel.fetchStadiums()
    }

    // MARK: -  methods

     func configureUI() {
        UIUtils.setupNavigationBars(navigationController)
        configureTableView()
    }

     func configureTableView() {
        tableView.register(UINib(nibName: "StadiumTableViewCell", bundle: nil), forCellReuseIdentifier: "StadiumTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.allowsSelection = true
        tableView.allowsSelectionDuringEditing = true
        tableView.allowsMultipleSelection = false
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.delaysContentTouches = false
        tableView.canCancelContentTouches = true
        tableView.panGestureRecognizer.isEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        let navBarTapGesture = UITapGestureRecognizer(target: self, action: #selector(titleViewTapped))
        navigationItem.titleView?.addGestureRecognizer(navBarTapGesture)
        navigationItem.titleView?.isUserInteractionEnabled = true
    }


    // MARK: - Actions

    @objc  func titleViewTapped() {
        tableView.setContentOffset(CGPoint.zero, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension StadiumListViewController: UITableViewDelegate {

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let stadiumDetailsVC = storyboard.instantiateViewController(withIdentifier: "StadiumDetailsViewController") as! StadiumDetailsViewController
          stadiumDetailsVC.stadium = stadiums[indexPath.row]
          navigationController?.pushViewController(stadiumDetailsVC, animated: true)
      }

      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 92.0
      }
}

// MARK: - UITableViewDataSource

extension StadiumListViewController: UITableViewDataSource {
    
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
}
