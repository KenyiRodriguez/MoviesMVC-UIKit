//
//  MovieInteractor.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import Foundation
import Combine

protocol MovieInteractorProtocol {
    var movieIsFavorite: Bool { get }
    func fetchDetail(completion: @escaping (Movie?) -> Void)
    func toggleFavoriteStatus(_ movie: Movie) -> Bool
}

class MovieInteractor: MovieInteractorProtocol {
    let idMovie: Int
    private let movieService: MovieServiceProtocol
    private let movieStorage: MovieStorageProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    var movieIsFavorite: Bool {
        self.movieStorage.getById(self.idMovie) != nil
    }
    
    init(idMovie: Int, movieService: MovieServiceProtocol, movieStorage: MovieStorageProtocol) {
        self.idMovie = idMovie
        self.movieService = movieService
        self.movieStorage = movieStorage
    }
    
    func fetchDetail(completion: @escaping (Movie?) -> Void) {
        self.movieService.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    completion(nil)
                }
            }, receiveValue: { movieDTO in
                let movie = Movie(dto: movieDTO)
                completion(movie)
            })
            .store(in: &cancellables)
    }
    
    func toggleFavoriteStatus(_ movie: Movie) -> Bool {
        self.movieIsFavorite ? self.movieStorage.delete(movie.idMovie) : self.movieStorage.add(movie)
        self.movieStorage.saveChanges()
        return self.movieIsFavorite
    }
}
