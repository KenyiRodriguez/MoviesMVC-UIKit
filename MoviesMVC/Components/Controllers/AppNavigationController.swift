//
//  AppNavigationController.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class AppNavigationController: UINavigationController {
    class func build() -> AppNavigationController {
        let controller = AppNavigationController(rootViewController: MoviesTabBarController.build())
        return controller
    }
}
