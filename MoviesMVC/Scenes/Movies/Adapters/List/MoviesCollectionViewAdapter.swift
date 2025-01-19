//
//  MoviesCollectionViewAdapter.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

protocol MoviesCollectionViewAdapter {
    var dataSource: [Any] { get set }
    func setCollectionView(_ collectionView: UICollectionView)
    func didSelectHandler(_ handler: @escaping (_ movie: Movie) -> Void)
}
