//
//  MoviesSearchByOverviewAdapter.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class MoviesSearchByDateAdapter: NSObject, MoviesSearchViewAdapter {

    var dataSource: [Movie] = []
    private var didFilter: ((_ arrayResult: [Any]) -> Void)?
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
        searchBar.placeholder = "Busca por fecha de lanzamiento"
    }
    
    func didFilterHandler(_ didFilter: @escaping (_ arrayResult: [Any]) -> Void) {
        self.didFilter = didFilter
    }
}

extension MoviesSearchByDateAdapter: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var arrayResult: [Any] = []
        
        if searchText.isEmpty {
            arrayResult = self.dataSource
        } else {
            arrayResult = self.dataSource.filter({
                $0.releaseDateFullFormat.lowercased().contains(searchText.lowercased())
            })
        }
        
        let finalArray = arrayResult.isEmpty ? ["No se encontraron resultados para la búsqueda de:\n\n \(searchText)"] :  arrayResult
        self.didFilter?(finalArray)
    }
}
