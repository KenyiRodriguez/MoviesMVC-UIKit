//
//  NavigationBarStyle.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

protocol NavigationBarStyle {
    func configure(_ viewController: UIViewController)
}


struct NavigationBarHide: NavigationBarStyle {
    
    func configure(_ viewController: UIViewController) {
        viewController.navigationController?.isNavigationBarHidden = true
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

struct NavigationBarSimpleShow: NavigationBarStyle {
    
    func configure(_ viewController: UIViewController) {
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationController?.navigationBar.tintColor = .black
    }
}

struct NavigationBarFullShow: NavigationBarStyle {
    
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    func configure(_ viewController: UIViewController) {
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationController?.navigationBar.tintColor = .black
        viewController.navigationItem.title = self.title
        let font = UIFont.boldSystemFont(ofSize: 19)
        viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
    }
}
