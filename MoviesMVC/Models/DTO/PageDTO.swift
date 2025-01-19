//
//  PageDTO.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 17/01/25.
//

import Foundation

struct PageDTO<T: Decodable>: Decodable {
    let page: Int?
    let results: [T]?
}
