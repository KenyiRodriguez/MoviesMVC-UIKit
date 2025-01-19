//
//  MoviesTabBarController.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class MoviesTabBarController: UITabBarController {
    
    private let navigationStyle: NavigationBarStyle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationStyle.configure(self)
    }
    
    init(navigationStyle: NavigationBarStyle) {
        self.navigationStyle = navigationStyle
        super.init(nibName: nil, bundle: nil)
        self.tabBar.backgroundColor = .white.withAlphaComponent(0.98)
        self.tabBar.isTranslucent = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func build() -> MoviesTabBarController {
        let controller = MoviesTabBarController(navigationStyle: NavigationBarFullShow(title: "Cinemark"))
        controller.viewControllers = [MoviesViewController.build(), MoviesFavoritiesViewController.build()]
        return controller
    }
}
