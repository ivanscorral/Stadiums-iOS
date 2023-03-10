//
//  StadiumDetailsViewController.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 10/3/23.
//

import UIKit

class StadiumDetailsViewController: UIViewController {
    
        
    public var stadium: Stadium? {
        didSet{
            guard let stadium = stadium else { return }
            title = stadium.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Add swipe gesture recognizer for swipe back
        let swipeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(dismissDetailsViewController))
        swipeGestureRecognizer.edges = .left
        view.addGestureRecognizer(swipeGestureRecognizer)
        
    }
    
    @objc private func dismissDetailsViewController() {
        navigationController?.popViewController(animated: true)
    }
    
}
