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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let stadium = stadium {
            setupUI(stadium)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
        setupBackButton()
    }
    
    // MARK: - Private Methods
    
    func setupUI(_ stadium: Stadium) {
        mapsButton.configuration?.imagePadding = 8.0
        stadiumTitleLabel.text = stadium.title
        stadiumCoordinatesLabel.text = "Las coordenadas de este estadio son: \(stadium.geocoordinates)"
        stadiumImageView.kf.setImage(with: URL(string: stadium.image))
        stadiumImageView.layer.cornerRadius = 32
        stadiumImageView.layer.masksToBounds = true

    }
       
    private func setupGestureRecognizers() {
        let swipeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(dismissDetailsViewController))
        swipeGestureRecognizer.edges = .left
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        backButton.tintColor = .label
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Actions
    
    @IBAction func openWithAppleMaps(_ sender: Any) {
        guard let stadium = stadium else { return }
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(stadium.latitude, stadium.longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = stadium.title
        mapItem.openInMaps(launchOptions: options)
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func dismissDetailsViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setTitle(_ title: String) {
        self.title = title
    }
    
}
