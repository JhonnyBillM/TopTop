//
//  MovieTableViewCell.swift
//  TopTop
//
//  Created by Oriontek iOS on 5/12/19.
//  Copyright © 2019 com.jhonny.learning. All rights reserved.
//

import Foundation
import UIKit

let movieCellReuseIdentifier = "movieTableViewCell"

class MovieTableViewCell: UITableViewCell {
    
    var numberLabel: UILabel!
    var movieImageView: UIImageView!
    var titleLabel: UILabel!
    var genreLabel: UILabel!
    var dateLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            showImage(from: movie.artworkUrl)
            titleLabel.text = movie.name
            genreLabel.text = movie.genres.first?.name ?? ""
            dateLabel.text = movie.rawReleaseDate
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
                    self.movieImageView.image = image
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
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.text = "Dummy Title"
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        
        genreLabel = UILabel()
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        genreLabel.adjustsFontSizeToFitWidth = true
        genreLabel.minimumScaleFactor = 0.5
        genreLabel.text = "Dummy Genre"
        genreLabel.textAlignment = .left
        genreLabel.textColor = .lightGray
        
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.5
        dateLabel.text = "May 12, 2016"
        dateLabel.textAlignment = .left
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(genreLabel)
        infoStackView.addArrangedSubview(dateLabel)
        
        numberLabel = UILabel()
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        numberLabel.text = "1"
        numberLabel.textAlignment = .left
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.minimumScaleFactor = 0.5
        
        movieImageView = UIImageView()
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        NSLayoutConstraint(item: movieImageView as Any,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: movieImageView as Any,
                           attribute: .width,
                           multiplier: 1 / (2/3),
                           constant: movieImageView.frame.height).isActive = true
        
        movieImageView.layer.shadowOffset = .zero
        movieImageView.layer.shadowColor = UIColor.gray.cgColor
        movieImageView.layer.shadowOpacity = 1
        movieImageView.layer.shadowRadius = 5
        
        movieStackView.addArrangedSubview(numberLabel)
        movieStackView.addArrangedSubview(movieImageView)
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

enum ImageError: Error {
    case noImage
}
