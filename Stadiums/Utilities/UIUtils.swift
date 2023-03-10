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
        
        let titleItem = UINavigationItem(title: "Stadiums")
        titleItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.items = [titleItem]
    }
    
    static func updateTitleText(_ navigationController: UINavigationController?, withText text: String) {
        guard let navigationController = navigationController else { return }
        guard let titleItem = navigationController.navigationBar.items?.first else { return }
        
        titleItem.title = text
    }
}


