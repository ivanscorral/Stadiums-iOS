//
//  UIUtils.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 10/3/23.
//

import Foundation
import UIKit

class UIUtils {
    static func setupNavigationBars(_ navigationController: UINavigationController?) {
        guard let navigationController = navigationController else { return }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        // Remove these lines; don't modify the navigation bar items directly.
        // let titleItem = UINavigationItem(title: "Stadiums")
        // titleItem.largeTitleDisplayMode = .always
        // navigationController.navigationBar.items = [titleItem]
    }
    
    static func updateTitleText(_ viewController: UIViewController?, withText text: String) {
        // Modify the `navigationItem` of the `viewController` instead of the `navigationController`.
        guard let viewController = viewController else { return }
        viewController.navigationItem.title = text
    }
}
