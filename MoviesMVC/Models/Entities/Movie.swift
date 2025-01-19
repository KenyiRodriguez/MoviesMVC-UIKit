//
//  Movie.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import Foundation

struct Movie {
    let idMovie: Int
    let title: String
    let voteAverage: Int
    let releaseDateString: String
    let posterPath: String
    let overview: String
    let genres: [Genre]
    
    var genresDescription: String {
        let genresName = self.genres.map({ $0.name })
        return genresName.joined(separator: " • ")
    }
    
    var urlImage: String {
        "https://image.tmdb.org/t/p/w500" + self.posterPath
    }
    
    var releaseDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "es_ar")
        return dateFormatter.date(from: self.releaseDateString)
    }
    
    var releaseDateFullFormat: String {
        guard let date = self.releaseDate else { return "Próximamente" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd 'de' MMMM 'del' yyyy"
        dateFormatter.locale = Locale(identifier: "es_PE")
        return dateFormatter.string(from: date)
    }
    
    var releaseDateShortFormat: String {
        guard let date = self.releaseDate else { return "Próximamente" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "es_PE")
        return dateFormatter.string(from: date)
    }
    
    init(dto: MovieDTO) {
        self.idMovie = dto.id ?? 0
        self.title = dto.title ?? "-"
        self.voteAverage = Int(dto.vote_average ?? 0)
        self.releaseDateString = dto.release_date ?? ""
        self.posterPath = dto.poster_path ?? ""
        self.overview = dto.overview ?? "--"
        self.genres = dto.genres?.map({ Genre(dto: $0) }) ?? []
    }

    init(dm: FavoriteMovie) {
        self.idMovie = Int(dm.id)
        self.title = dm.title ?? ""
        self.voteAverage = Int(dm.voteAverage)
        self.overview = "Sin descripción"
        self.posterPath = dm.posterPath ?? ""
        self.releaseDateString = dm.releaseDate ?? ""
        self.genres = []
    }
}

extension Movie {
    struct Genre {
        let idGenre: Int
        let name: String
        
        init(dto: GenreDTO) {
            self.idGenre = dto.id ?? 0
            self.name = dto.name ?? ""
        }
    }
}
