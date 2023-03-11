//  StadiumListViewController.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 9/3/23.
//

import UIKit

class StadiumListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
     let viewModel = StadiumListViewModel()
     var allStadiums: [Stadium] = []
     var filteredStadiums: [Stadium] = [] {
        didSet {
            tableView.reloadData()
            stadiumsDidChange?(.success(filteredStadiums))
        }
    }
    var stadiumsDidChange: ((Result<[Stadium], Error>) -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        viewModel.fetchStadiums()
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        UIUtils.setupNavigationBars(navigationController)
        configureTableView()
    }
    
    private func configureTableView() {
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
    
    @objc private func titleViewTapped() {
        tableView.setContentOffset(CGPoint.zero, animated: true)
    }
}
