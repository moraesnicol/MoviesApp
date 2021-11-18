//
//  File.swift
//  MoviesApp
//
//  Created by Gabriel on 17/11/21.
//

import Foundation

struct Response: Codable {
    var dates: Date?
    var page: Int?
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
}

struct Movie: Codable {
    var adult: Bool?
    var backImage: String?
    var genreID: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var description: String?
    var popularity: Double?
    var poster: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var avaliation: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case genreID = "genre_ids"
        case backImage = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case description = "overview"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case avaliation = "vote_average"
        case voteCount = "vote_count"
    }
}

struct Date: Codable {
    var DateMaximum: String?
    var DateMinimum: String?
}
