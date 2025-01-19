//
//  ListMoviesOnlineAdapter.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class MoviesOnlineAdapter: NSObject, MoviesCollectionViewAdapter {
    
    private weak var collectionView: UICollectionView?
    private var didSelect: ((_ movie: Movie) -> Void)?
    
    var dataSource = [Any]() {
        didSet { self.dataSource.first is Movie ? self.setMoviesLayout() : self.setErrorLayout() }
    }
    
    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        self.collectionView?.register(ErrorCollectionViewCell.self, forCellWithReuseIdentifier: ErrorCollectionViewCell.identifier)
        self.setMoviesLayout()
    }
    
    func didSelectHandler(_ handler: @escaping (_ movie: Movie) -> Void) {
        self.didSelect = handler
    }
}

extension MoviesOnlineAdapter {
    private func setMoviesLayout() {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(190))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)
        section.interGroupSpacing = 20
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = layout
    }
    
    private func setErrorLayout() {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = layout
    }
}

extension MoviesOnlineAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.dataSource[indexPath.row]
        if let movie = item as? Movie {
            return MovieCollectionViewCell.buildIn(collectionView, indexPath: indexPath, movie: movie)
        } else if let errorMessage = item as? String {
            return ErrorCollectionViewCell.buildIn(collectionView, indexPath: indexPath, errorMessage: errorMessage)
        } else {
            return UICollectionViewCell()
        }
    }
}

extension MoviesOnlineAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = self.dataSource[indexPath.row] as? Movie {
            self.didSelect?(movie)
        }
    }
}
