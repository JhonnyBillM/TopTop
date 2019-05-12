//
//  Genre.swift
//  TopTop
//
//  Created by Oriontek iOS on 5/12/19.
//  Copyright © 2019 com.jhonny.learning. All rights reserved.
//

import Foundation

/// Defines an iTunes Media Genre.
struct Genre: Codable {
    var id: String
    var name: String
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "genreId"
        case name
        case url
    }
}
