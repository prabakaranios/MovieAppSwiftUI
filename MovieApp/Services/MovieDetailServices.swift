//
//  MovieDetailServices.swift
//  MovieApp
//
//  Created by Prabakaran Kuppusamy on 30/07/21.
//

import Foundation

class MovieDetailServices {
    
    func getMovieDetail(movieId: Int, completion: @escaping (MovieDetail?) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=a371f045b3ab77663a5c1143a9fb9da1") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let movieDetailResponse = try? JSONDecoder().decode(MovieDetail.self, from: data)
            if let movieDetail = movieDetailResponse {
                completion(movieDetail)
            } else {
                completion(nil)
            }
            
        }.resume()
    }
}
