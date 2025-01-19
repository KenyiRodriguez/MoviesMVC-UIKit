//
//  MoviesSearchViewAdapter.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

protocol MoviesSearchViewAdapter {
    var dataSource: [Movie] { get set }
    func setSearchBar(_ searchBar: UISearchBar)
    func didFilterHandler(_ didFilter: @escaping (_ arrayResult: [Any]) -> Void)
}
