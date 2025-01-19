//
//  MovieDTO.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 17/01/25.
//

import Foundation

struct MovieDTO: Decodable {
    let id: Int?
    let title: String?
    let vote_average: Double?
    let release_date: String?
    let poster_path: String?
    let overview: String?
    let genres: [GenreDTO]?
}

extension MovieDTO {
    static var mock: MovieDTO {
        MovieDTO(id: 762509,
                 title: "Mufasa: El rey león",
                 vote_average: 7.4,
                 release_date: "2024-12-18",
                 poster_path: "/lk4NNdeQrb6zbRSogDSdE6qmjk8.jpg",
                 overview: "Rafiki debe transmitir la leyenda de Mufasa a la joven cachorro de león Kiara, hija de Simba y Nala, y con Timón y Pumba prestando su estilo característico. Mufasa, un cachorro huérfano, perdido y solo, conoce a un simpático león llamado Taka, heredero de un linaje real. Este encuentro casual pone en marcha un viaje de un extraordinario grupo de inadaptados que buscan su destino.",
                 genres: [GenreDTO.mock, GenreDTO.mock, GenreDTO.mock])
    }
}
