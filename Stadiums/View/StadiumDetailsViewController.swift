//
//  StadiumDetailsViewController.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 10/3/23.
//

import UIKit
import MapKit
import Kingfisher

class StadiumDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var stadiumCoordinatesLabel: UILabel!
    @IBOutlet weak var stadiumImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stadiumTitleLabel: UILabel!
    @IBOutlet weak var mapsButton: UIButton!
    
    // MARK: - Properties
    
    public var stadium: Stadium? {
        didSet{
            guard let stadium = stadium else { return }
            setTitle("Detalles de: \(stadium.title)")
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
        setupBackButton()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    /// Sets up the user interface
    private func setupUI() {
        if let stadium = stadium {
            // Set up stadium title label
            stadiumTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
            stadiumTitleLabel.text = stadium.title
            
            // Set up stadium coordinates label
            stadiumCoordinatesLabel.font = UIFont.systemFont(ofSize: 18)
            stadiumCoordinatesLabel.text = "Las coordenadas de este estadio son: \(stadium.geocoordinates)"
            
            // Set up stadium image view
            stadiumImageView.kf.setImage(with: URL(string: stadium.image))
            stadiumImageView.layer.cornerRadius = 32
            stadiumImageView.layer.masksToBounds = true
            stadiumImageView.layer.shadowColor = UIColor.black.cgColor
            stadiumImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
            stadiumImageView.layer.shadowOpacity = 0.2
            stadiumImageView.layer.shadowRadius = 4
            
            // Set up maps button
            mapsButton.backgroundColor = .clear
            mapsButton.layer.cornerRadius = 16
            mapsButton.layer.borderWidth = 1
            mapsButton.layer.borderColor = UIColor.systemGray.cgColor
            mapsButton.setTitleColor(.systemGray, for: .normal)
        }
    }
    
    /// Sets up swipe gesture recognizer to dismiss the view controller
    private func setupGestureRecognizers() {
        let swipeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(backButtonPressed))
        swipeGestureRecognizer.edges = .left
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    /// Sets up the back button
    private func setupBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        backButton.tintColor = .label
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Actions
    
    /// Opens the Apple Maps app with the stadium location
    
    @IBAction func openWithAppleMaps(_ sender: Any) {
        guard let stadium = stadium else { return }
        
        // Set the region to show in Apple Maps
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(stadium.latitude, stadium.longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        // Set the launch options for Apple Maps
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), // Center the map on the stadium location
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span) // Set the zoom level for the map
        ]
        
        // Create a placemark for the stadium location and open it in Apple Maps
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = stadium.title
        mapItem.openInMaps(launchOptions: options)
    }
    
    /// Handles the back button being pressed
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    /// Sets the title of the view controller
    private func setTitle(_ title: String) {
        self.title = title
    }
}
