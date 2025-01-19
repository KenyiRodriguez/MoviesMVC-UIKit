//
//  MoviesLocalViewController.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 15/01/25.
//

import UIKit

class MoviesFavoritiesViewController: UIViewController {
    
    private let moviesView: MoviesViewProtocol
    private let moviesInteractor: MoviesFavoritesInteractorProtocol

    init(view: MoviesViewProtocol, 
         moviesInteractor: MoviesFavoritesInteractorProtocol) {
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
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAll()
    }
}

extension MoviesFavoritiesViewController {
    private func setupView() {
        guard let moviesView = self.moviesView as? UIView else { return }
        self.view = moviesView
        self.moviesView.delegate = self
    }
    
    private func getAll() {
        self.moviesInteractor.fetch { movies in
            self.moviesView.reloadData(movies.isEmpty ? ["Add favorites movies to load this section"] : movies)
        }
    }
}

extension MoviesFavoritiesViewController: MoviesViewDelegate {
    func moviesView(_ view: MoviesViewProtocol, didSelectMovies movie: Movie) {
        let controller = MovieViewController.buildWith(movie.idMovie)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MoviesFavoritiesViewController {
    
    class func build() -> MoviesFavoritiesViewController {
        let listAdapter = MoviesFavoritesAdapter()
        let searchAdapter = MoviesSearchByDateAdapter()
        let moviesStorage = MovieStorage(dataManager: DataManager.current)

        let moviesInteractor = MoviesFavoritesInteractor(moviesStorage: moviesStorage)
                
        let view = MoviesView(listAdapter: listAdapter,
                              searchAdapter: searchAdapter)

        let controller = MoviesFavoritiesViewController(view: view, 
                                                        moviesInteractor: moviesInteractor)
        
        controller.tabBarItem.title = "Favorites"
        controller.tabBarItem.image = UIImage(systemName: "star")
        controller.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        return controller
    }
}
