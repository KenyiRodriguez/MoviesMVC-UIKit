//
//  MoviesInteractor.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import Foundation
import Combine

protocol MoviesInteractorProtocol {
    func fetch(completion: @escaping ([Movie]) -> Void)
}

class MoviesInteractor: MoviesInteractorProtocol {
    private let moviesService: MoviesServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(moviesService: MoviesServiceProtocol) {
        self.moviesService = moviesService
    }
    
    func fetch(completion: @escaping ([Movie]) -> Void) {
        self.moviesService.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    completion([])
                }
            }, receiveValue: { moviesDTO in
                let movies = moviesDTO.map({ Movie(dto: $0) })
                completion(movies)
            })
            .store(in: &cancellables)
    }
}
