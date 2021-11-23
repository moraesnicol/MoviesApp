//
//  ViewController.swift
//  MoviesApp
//
//  Created by Gabriel on 17/11/21.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    
    private var responseMovie: [Movie] = []
    private let apiService = APIService()
    private var resultMovie: Movie
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ListMovieCell.self, forCellReuseIdentifier: ListMovieCell.identifier)
        table.separatorStyle = .singleLine
        table.backgroundColor = .primary
        return table
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.frame = (.zero)
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageDetailView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        apiService.fecthData(page: 1 ) { [weak self] (response) in
            guard let self = self else {return}
            self.responseMovie = response ?? []
            DispatchQueue.main.async  {
                self.tableView.reloadData()
            }
        }
    }
    
    init(resultMovie: Movie){
        self.resultMovie = resultMovie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchDetailMovieImage(movie: Movie) {
        let poster: String? = movie.poster ?? ""
        let baseUrl = "https://image.tmdb.org/t/p/w300\(poster!)"
        let imagePlaceHolder = UIImageView()
        imagePlaceHolder.contentMode = .scaleAspectFill
        imagePlaceHolder.image = .placeHolderImage
        
        DispatchQueue.main.async {
            guard let url = URL(string: baseUrl ) else { return }
            let resource = ImageResource(downloadURL: url, cacheKey: movie.poster)
            let placeholder = imagePlaceHolder.image
            self.imageDetailView.kf.setImage(with: resource, placeholder: placeholder)
        }
    }
    
}

extension DetailViewController: ViewCode {
    
    func setupComponents() {
        view.addSubview(detailView)
        view.addSubview(imageDetailView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            imageDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            imageDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageDetailView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -80),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
    }
    
    func setupExtraConfiguration() {
        view.backgroundColor = .primary
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseMovie.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieCell.identifier, for: indexPath) as? ListMovieCell else {fatalError("Cell dont find :(")}
        resultMovie = responseMovie[indexPath.row]
        cell.fetchMovie(movie: resultMovie)
        return cell
    }
}

