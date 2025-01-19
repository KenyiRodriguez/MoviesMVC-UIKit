//
//  GenreDTO.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 17/01/25.
//

import Foundation

struct GenreDTO: Decodable {
    let id: Int?
    let name: String?
}

extension GenreDTO {
    static var mock: GenreDTO {
        GenreDTO(id: 12, name: "Aventura")
    }
}
