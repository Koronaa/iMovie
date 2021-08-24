//
//  MoviesReponse.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation

struct MoviesResponse: Codable {
    let count: Int?
    let results: [MovieInfo]?
}

struct MovieInfo: Codable {
    let title: String
    let openingCrawl, director, producer, releaseDate: String
    let characterEndpoints:[String]
    let posterURL:URL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/64/Poster_not_available.jpg")!

    enum CodingKeys: String, CodingKey {
        case title
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case characterEndpoints = "characters"
    }
}


