//
//  DetailCell.swift
//  MoviesApp
//
//  Created by Gabriel on 17/11/21.
//

import UIKit
import Combine
import Kingfisher


final class ListMovieCell: UITableViewCell {
    
    static let identifier = "ListMovieCell"
    
    private var moviePoster = UIImageView()
    private var movieTitle = UILabel()
    private var movieSubTitle = UILabel()
    
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.text = "Any Title"
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.text = "Any SubTitle"
        return label
    }()
    
    private lazy var imagePoster: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage.placeHolderImage
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
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePoster.image = UIImage.placeHolderImage
        imagePoster.kf.cancelDownloadTask()
    }
    
}

extension ListMovieCell: ViewCode {
    
    func setupComponents() {
        contentView.addSubview(imagePoster)
        contentView.addSubview(title)
        contentView.addSubview(subTitle)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imagePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imagePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imagePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            imagePoster.heightAnchor.constraint(equalToConstant: 190),
            imagePoster.widthAnchor.constraint(equalToConstant: 190),

            title.topAnchor.constraint(equalTo: imagePoster.topAnchor, constant: 50),
            title.leadingAnchor.constraint(equalTo: imagePoster.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
    
            subTitle.topAnchor.constraint(equalTo: title.topAnchor, constant: 5),
            subTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
}
