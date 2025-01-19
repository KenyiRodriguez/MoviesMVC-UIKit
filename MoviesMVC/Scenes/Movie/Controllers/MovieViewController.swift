//
//  DetailMovieViewController.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class MovieViewController: UIViewController {
 
    private var movieView: MovieViewProtocol
    private let movieInteractor: MovieInteractorProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.getDetail()
    }

    init(view: MovieViewProtocol, movieInteractor: MovieInteractorProtocol) {
        self.movieView = view
        self.movieInteractor = movieInteractor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieViewController {
    
    private func getDetail() {
        self.movieView.showLoading(true)
        self.movieInteractor.fetchDetail { movie in
            self.movieView.showLoading(false)
            self.movieView.movie = movie
            self.movieView.setFavoriteStyle(self.movieInteractor.movieIsFavorite)
        }
    }
    
    private func setupView() {
        guard let movieView = self.movieView as? UIView else { fatalError("La vista debe ser un UIView.") }
        self.movieView.delegate = self
        self.view = movieView
    }
    
    private func addToFavorite(_ movie: Movie) {
        let isFavorite = self.movieInteractor.toggleFavoriteStatus(movie)
        self.movieView.setFavoriteStyle(isFavorite)
    }
}

extension MovieViewController: MovieViewDelegate {
    
    func detailMovieView(_ view: MovieViewProtocol, toogleFavorite movie: Movie) {
        self.addToFavorite(movie)
    }
}

extension MovieViewController {
    
    class func buildWith(_ idMovie: Int) -> MovieViewController {
        let view = MovieView()
        let movieService = MovieService(idMovie: idMovie)
        let movieStorage = MovieStorage(dataManager: DataManager.current)
        let movieInteractor = MovieInteractor(idMovie: idMovie,
                                              movieService: movieService,
                                              movieStorage: movieStorage)
        return MovieViewController(view: view,
                                         movieInteractor: movieInteractor)
    }
}
