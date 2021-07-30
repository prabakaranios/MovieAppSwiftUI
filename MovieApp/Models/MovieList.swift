//
//  MovieList.swift
//  MovieApp
//
//  Created by Prabakaran Kuppusamy on 30/07/21.
//

import Foundation

struct Movies: Codable {
    var items: [MovieItem]?
    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}

struct MovieItem: Identifiable,Codable {
    var id: Int
    var title: String
    var overview : String
    var path: String
    var url: String {
        "http://image.tmdb.org/t/p/" + "w300/" + path
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case overview
        case path = "poster_path"
    }

}

