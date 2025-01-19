//
//  GetAllMoviesService.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import Foundation
import Alamofire
import Combine

protocol MoviesServiceProtocol {
    func fetch() -> AnyPublisher<[MovieDTO], Never>
}

struct MoviesService: MoviesServiceProtocol {
        
    private var url: String { "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c&language=es" }

    func fetch() -> AnyPublisher<[MovieDTO], Never> {
        return AF.request(self.url)
            .publishData()
            .compactMap { $0.data }
            .decode(type: PageDTO<MovieDTO>.self, decoder: JSONDecoder())
            .map { $0.results ?? [] }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
