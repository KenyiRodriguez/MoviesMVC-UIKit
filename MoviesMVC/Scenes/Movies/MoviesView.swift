//
//  MoviesListView.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit
import SwiftUI

protocol MoviesViewDelegate: AnyObject {
    func moviesViewBeginRefreshing(_ view: MoviesViewProtocol)
    func moviesView(_ view: MoviesViewProtocol, didSelectMovies movie: Movie)
}

extension MoviesViewDelegate {
    func moviesViewBeginRefreshing(_ view: MoviesViewProtocol) { }
}

protocol MoviesViewProtocol: NSObjectProtocol {
    
    var delegate: MoviesViewDelegate? { get set }
    
    func addPullToRefresh()
    func showLoading(_ isShow: Bool)
    func reloadData(_ array: [Any])
}

class MoviesView: UIView {
    
    unowned var delegate: MoviesViewDelegate?
    private var listAdapter: MoviesCollectionViewAdapter
    private var searchAdapter: MoviesSearchViewAdapter
    
    private lazy var clvMovies = GenericCollectionView()
    private lazy var srcMovies = GenericSearchBar()
    
    private lazy var refreshControl = GenericRefreshControl {
        self.delegate?.moviesViewBeginRefreshing(self)
    }

    init(listAdapter: MoviesCollectionViewAdapter, 
         searchAdapter: MoviesSearchViewAdapter) {
        self.listAdapter = listAdapter
        self.searchAdapter = searchAdapter
        super.init(frame: .zero)
        self.addElements()
        self.setupAdapters()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoviesView: MoviesViewProtocol {
    
    func addPullToRefresh() {
        self.clvMovies.addSubview(self.refreshControl)
    }
    
    func showLoading(_ isShow: Bool) {
        isShow ? self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
    }
    
    func reloadData(_ array: [Any]) {
        self.searchAdapter.dataSource = array as? [Movie] ?? []
        self.reloadTable(array)
    }
}

extension MoviesView {
    
    private func reloadTable(_ array: [Any]) {
        self.listAdapter.dataSource = array
        self.clvMovies.reloadData()
    }
    
    private func setupAdapters() {
        self.searchAdapter.setSearchBar(self.srcMovies)
        self.listAdapter.setCollectionView(self.clvMovies)
        
        self.searchAdapter.didFilterHandler { arrayResult in
            self.reloadTable(arrayResult)
        }
        
        self.listAdapter.didSelectHandler { movie in
            self.delegate?.moviesView(self, didSelectMovies: movie)
        }
    }
    
    private func addElements() {
        self.backgroundColor = .white
        self.addSubview(self.srcMovies)
        self.addSubview(self.clvMovies)

        NSLayoutConstraint.activate([
            self.srcMovies.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.srcMovies.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.srcMovies.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.clvMovies.topAnchor.constraint(equalTo: self.srcMovies.bottomAnchor),
            self.clvMovies.leadingAnchor.constraint(equalTo: self.srcMovies.leadingAnchor),
            self.clvMovies.trailingAnchor.constraint(equalTo: self.srcMovies.trailingAnchor),
            self.clvMovies.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])       
    }
}

fileprivate struct MoviesListViewRepresentable: UIViewRepresentable {
    
    let type: `Type`
    
    func makeUIView(context: Context) -> MoviesView {
        let adapters = self.type.adapters
        let movies = [MovieDTO.mock, MovieDTO.mock, MovieDTO.mock, MovieDTO.mock].map({ Movie(dto: $0) })
        let view = MoviesView(listAdapter: adapters.list,
                                  searchAdapter: adapters.search)
        view.reloadData(movies)
        return view
    }
    
    func updateUIView(_ uiView: MoviesView, context: Context) { }
    
    enum `Type` {
        case online
        case local
        
        var adapters: (list: MoviesCollectionViewAdapter, search: MoviesSearchViewAdapter) {
            switch self {
            case .online: (MoviesOnlineAdapter(), MoviesSearchByNameAdapter())
            case .local: (MoviesFavoritesAdapter(), MoviesSearchByDateAdapter())
            }
        }
    }
}

fileprivate struct MoviesListViewPreview: PreviewProvider {
    static var previews: some View { MoviesListViewRepresentable(type: .online) }
}
