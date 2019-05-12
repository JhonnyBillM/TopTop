//
//  PlaylistTableViewCell.swift
//  TopTop
//
//  Created by Oriontek iOS on 5/12/19.
//  Copyright © 2019 com.jhonny.learning. All rights reserved.
//

import Foundation
import UIKit

let playlistCellReuseIdentifier = "playlistTableViewCell"

class PlaylistTableViewCell: UITableViewCell {
    
    var numberLabel: UILabel!
    var playlistImageView: UIImageView!
    var titleLabel: UILabel!
    
    var playlist: Playlist? {
        didSet {
            guard let playlist = playlist else { return }
            showImage(from: playlist.artworkUrl)
            titleLabel.text = playlist.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showImage(from url: URL) {
        loadImage(from: url) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.playlistImageView.image = image
                case .failure(_):
                    break
                }
            }
        }
    }
    
    private func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { completion(.failure(ImageError.noImage)) ; return }
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(ImageError.noImage))
            }
            }.resume()
    }
    
    private func setUpCell() {
        
        let movieStackView = UIStackView(frame: frame)
        movieStackView.translatesAutoresizingMaskIntoConstraints = false
        movieStackView.alignment = .center
        movieStackView.distribution = .fillProportionally
        movieStackView.axis = .horizontal
        movieStackView.spacing = 10
        addSubview(movieStackView)
        
        let infoStackView = UIStackView(frame: movieStackView.frame)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.alignment = .fill
        infoStackView.distribution = .fill
        infoStackView.axis = .vertical
        infoStackView.spacing = 5
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.text = "Dummy Title"
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        
        infoStackView.addArrangedSubview(titleLabel)
        
        numberLabel = UILabel()
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        numberLabel.text = "1"
        numberLabel.textAlignment = .left
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.minimumScaleFactor = 0.5
        
        playlistImageView = UIImageView()
        playlistImageView.translatesAutoresizingMaskIntoConstraints = false
        playlistImageView.contentMode = .scaleAspectFit
        playlistImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        NSLayoutConstraint(item: playlistImageView as Any,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: playlistImageView as Any,
                           attribute: .width,
                           multiplier: 1 / (2/3),
                           constant: playlistImageView.frame.height).isActive = true
        
        playlistImageView.layer.shadowOffset = .zero
        playlistImageView.layer.shadowColor = UIColor.purple.cgColor
        playlistImageView.layer.shadowOpacity = 0.5
        playlistImageView.layer.shadowRadius = 3
        
        movieStackView.addArrangedSubview(numberLabel)
        movieStackView.addArrangedSubview(playlistImageView)
        movieStackView.addArrangedSubview(infoStackView)
        
        numberLabel.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        NSLayoutConstraint.activate([
            movieStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            movieStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            movieStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            movieStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
