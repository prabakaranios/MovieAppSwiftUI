//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Prabakaran Kuppusamy on 30/07/21.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    
    private var movieDetailService: MovieDetailServices!
    private var movieId: Int
    @Published var movieDetail = MovieDetail()
    
    init(movieId: Int) {
        self.movieId = movieId
        self.movieDetailService = MovieDetailServices()
    }
    
    func getMoviewDetail() {
        self.movieDetailService.getMovieDetail(movieId: self.movieId) { detail in
            if let movieDetail = detail {
                DispatchQueue.main.async {
                    self.movieDetail = movieDetail
                }
            }
        }
    }
}
