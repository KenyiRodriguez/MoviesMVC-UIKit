//
//  MoviesFavoritesInteractor.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import Foundation
import Combine

protocol MoviesFavoritesInteractorProtocol {
    func fetch(completion: @escaping ([Movie]) -> Void)
}

class MoviesFavoritesInteractor: MoviesFavoritesInteractorProtocol {
    private let moviesStorage: MovieStorageProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(moviesStorage: MovieStorage) {
        self.moviesStorage = moviesStorage
    }
    
    func fetch(completion: @escaping ([Movie]) -> Void) {
        let result = self.moviesStorage.listAll()
        let movies = result.map({ Movie(dm: $0) })
        completion(movies)
    }
}
