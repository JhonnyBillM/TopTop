//
//  Movie.swift
//  TopTop
//
//  Created by Oriontek iOS on 5/12/19.
//  Copyright © 2019 com.jhonny.learning. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var name: String
    var rawReleaseDate: String = ""
    var artworkUrl: URL
    var genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case name
        case rawReleaseDate = "releaseDate"
        case artworkUrl = "artworkUrl100"
        case genres
    }
}
