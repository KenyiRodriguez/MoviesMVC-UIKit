//
//  GetMovieDetailService.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import Foundation
import Alamofire
import Combine

protocol MovieServiceProtocol {
    func fetch() -> AnyPublisher<MovieDTO, Error>
}

struct MovieService: MovieServiceProtocol {
    
    let idMovie: Int
    
    private var url: String {
        "https://api.themoviedb.org/3/movie/\(self.idMovie)?api_key=752cd23fdb3336557bf3d8724e115570&language=es"
    }
    
    func fetch() -> AnyPublisher<MovieDTO, Error> {
        return AF.request(self.url)
            .publishData()
            .compactMap { $0.data }
            .decode(type: MovieDTO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
