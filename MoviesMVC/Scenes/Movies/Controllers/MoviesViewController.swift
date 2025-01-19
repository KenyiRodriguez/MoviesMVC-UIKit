//
//  MoviesOnlineViewController.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 15/01/25.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {
    
    private let moviesView: MoviesViewProtocol
    private let moviesInteractor: MoviesInteractorProtocol
    
    init(view: MoviesViewProtocol, moviesInteractor: MoviesInteractorProtocol) {
        self.moviesView = view
        self.moviesInteractor = moviesInteractor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.fetchMovies()
    }
}

extension MoviesViewController {
    private func fetchMovies() {
        self.moviesView.showLoading(true)
        self.moviesInteractor.fetch { movies in
            self.moviesView.showLoading(false)
            self.moviesView.reloadData(movies.isEmpty ? ["We can't find results"] : movies)
        }
    }
    
    private func setupView() {
        guard let moviesView = self.moviesView as? UIView else { return }
        self.view = moviesView
        self.moviesView.delegate = self
        self.moviesView.addPullToRefresh()
    }
}

extension MoviesViewController: MoviesViewDelegate {
    func moviesViewBeginRefreshing(_ view: MoviesViewProtocol) {
        self.fetchMovies()
    }
    
    func moviesView(_ view: MoviesViewProtocol, didSelectMovies movie: Movie) {
        let controller = MovieViewController.buildWith(movie.idMovie)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MoviesViewController {
    class func build() -> MoviesViewController {
        let listAdapter = MoviesOnlineAdapter()
        let searchAdapter = MoviesSearchByNameAdapter()
        let moviesService = MoviesService()
        
        let moviesInteractor = MoviesInteractor(moviesService: moviesService)
        
        let view = MoviesView(listAdapter: listAdapter,
                              searchAdapter: searchAdapter)
        
        let controller = MoviesViewController(view: view,
                                              moviesInteractor: moviesInteractor)
        
        controller.tabBarItem.title = "Movies"
        controller.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        controller.tabBarItem.selectedImage = UIImage(systemName: "square.grid.2x2.fill")
        
        return controller
    }
}
