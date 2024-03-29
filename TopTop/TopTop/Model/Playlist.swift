//
//  Playlist.swift
//  TopTop
//
//  Created by Oriontek iOS on 5/12/19.
//  Copyright © 2019 com.jhonny.learning. All rights reserved.
//

import Foundation

struct Playlist: Codable {
    var name: String
    var artworkUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case artworkUrl = "artworkUrl100"
    }
}
