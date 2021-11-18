//
//  DetailCell.swift
//  MoviesApp
//
//  Created by Gabriel on 17/11/21.
//

import UIKit
import Kingfisher


final class ListMovieCell: UITableViewCell {
    
    static let identifier = "ListMovieCell"
    
    private lazy var movieGenre: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var imagePoster: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: ListMovieCell.identifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let margins = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePoster.image = UIImage.placeHolderImage
        imagePoster.kf.cancelDownloadTask()
    }
    
    func fetchMovie(movie: Movie) {
        let poster: String? = movie.poster ?? ""
        let baseUrl = "https://image.tmdb.org/t/p/w300\(poster!)"
        let imagePlaceHolder = UIImageView()
        imagePlaceHolder.contentMode = .scaleAspectFit
        imagePlaceHolder.image = .placeHolderImage
        
        DispatchQueue.main.async {
            guard let url = URL(string: baseUrl ) else { return }
            let resource = ImageResource(downloadURL: url, cacheKey: movie.poster)
            let placeholder = imagePlaceHolder.image
            self.imagePoster.kf.setImage(with: resource, placeholder: placeholder)

            if let titleOptional = movie.releaseDate{
                let titleMovie = titleOptional
                
                let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from: titleMovie)
                
                dateFormatter.dateFormat = "yyyy"
                    let dateString = dateFormatter.string(from: date!)
          
                self.movieGenre.text = dateString
                
            }
            
            if let titleOriginalOptional = movie.originalTitle {
                let titleOriginal = titleOriginalOptional
                self.subTitle.text = titleOriginal
            }
        }
    }
}


extension ListMovieCell: ViewCode {
    
    func setupComponents() {
        contentView.addSubview(imagePoster)
        contentView.addSubview(movieGenre)
        contentView.addSubview(subTitle)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imagePoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            imagePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            imagePoster.heightAnchor.constraint(equalToConstant: 190),
            imagePoster.widthAnchor.constraint(equalToConstant: 190),

            subTitle.leadingAnchor.constraint(equalTo: imagePoster.trailingAnchor, constant: 2),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            subTitle.centerYAnchor.constraint(equalTo: imagePoster.centerYAnchor),
            
            movieGenre.topAnchor.constraint(equalTo: subTitle.topAnchor, constant: 40),
            movieGenre.leadingAnchor.constraint(equalTo: imagePoster.trailingAnchor, constant: 2),
            movieGenre.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    func setupExtraConfiguration() {
        selectionStyle = .none
        backgroundColor = .secondary
    }
}
