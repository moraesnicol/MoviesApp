//
//  ViewController.swift
//  MoviesApp
//
//  Created by Gabriel on 17/11/21.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var responseMovie: [Movie] = []
    private let apiService = APIService()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ListMovieCell.self, forCellReuseIdentifier: ListMovieCell.identifier)
        table.separatorStyle = .singleLine
        table.backgroundColor = .primary
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        apiService.fecthData(page: 1 ) { [weak self] (response) in
            guard let self = self else {return}
            self.responseMovie = response ?? []
            DispatchQueue.main.async  {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension DetailViewController: ViewCode {
    
    func setupComponents() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
    }
    
    func setupExtraConfiguration() {
        view.backgroundColor = .primary
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

        let resultMovie: Movie
        resultMovie = responseMovie[indexPath.row]
        cell.fetchMovie(movie: resultMovie)
    
        return cell
    }
}

