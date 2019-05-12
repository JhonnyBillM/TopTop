//
//  Networking.swift
//  TopTop
//
//  Created by Oriontek iOS on 5/12/19.
//  Copyright © 2019 com.jhonny.learning. All rights reserved.
//

import Foundation

struct Networking {
    
    static let shared = Networking()
    
    /// Fetches the top 25 movies from iTunes.
    ///
    /// - Parameters:
    ///     - result: Result type with movie's array as it's success case and Swift.Error as it's failure case.
    func movies(completion: @escaping (_ result: Result<[Movie], Error>) -> Void) {
        let _url = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/25/explicit.json"
        guard let url = URL(string: _url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] else { return }
                guard let feed = json["feed"] as? [String : Any] else { return }
                guard let results = feed["results"] else { return }
                
                let resultsData = try JSONSerialization.data(withJSONObject: results)
                let movies = try JSONDecoder().decode([Movie].self, from: resultsData)
                completion(.success(movies))
            } catch let err {
                print(err.localizedDescription)
                completion(.failure(err))
            }
        }.resume()
    }
    
    
    /// Fetches the top 25 playlists from Apple Music.
    ///
    /// - Parameters:
    ///     - result: Result type with playlist's array as it's success case and Swift.Error as it's failure case.
    func playlists(completion: @escaping (_ result: Result<[Playlist], Error>) -> Void) {
        let _url = "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/25/explicit.json"
        guard let url = URL(string: _url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] else { return }
                guard let feed = json["feed"] as? [String : Any] else { return }
                guard let results = feed["results"] else { return }
                
                let resultsData = try JSONSerialization.data(withJSONObject: results)
                let playlists = try JSONDecoder().decode([Playlist].self, from: resultsData)
                completion(.success(playlists))
            } catch let err {
                print(err.localizedDescription)
                completion(.failure(err))
            }
        }.resume()
    }
}
