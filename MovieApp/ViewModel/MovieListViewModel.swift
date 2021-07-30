//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Prabakaran Kuppusamy on 30/07/21.
//

import Foundation
import Combine

class MovieListViewModel:ObservableObject, RandomAccessCollection {
    
    typealias Element = MovieItem
    
    @Published var movieList = [MovieItem]()
    
    var startIndex: Int { movieList.startIndex }
    var endIndex: Int { movieList.endIndex }
    var loadStatus = LoadStatus.ready(nextPage: 1)
    
    var urlBase = "https://api.themoviedb.org/3/movie/popular?api_key=a371f045b3ab77663a5c1143a9fb9da1&page="
    
    subscript(position: Int) -> MovieItem {
        return movieList[position]
    }
    
    init() {
        loadMoreMovies()
    }
    
    func loadMoreMovies(currentItem: MovieItem? = nil) {
        
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        guard case let .ready(page) = loadStatus else {
            return
        }
        loadStatus = .loading(page: page)
        let urlString = "\(urlBase)\(page)"
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: parseArticlesFromResponse(data:response:error:))
        task.resume()
    }
    
    func shouldLoadMoreData(currentItem: MovieItem? = nil) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (movieList.count - 4)...(movieList.count-1) {
            if n >= 0 && currentItem.id == movieList[n].id {
                return true
            }
        }
        return false
    }
    
    func parseArticlesFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            loadStatus = .parseError
            return
        }
        guard let data = data else {
            print("No data found")
            loadStatus = .parseError
            return
        }
        
        let newArticles = parseMoviesFromData(data: data)
        DispatchQueue.main.async {
            self.movieList.append(contentsOf: newArticles)
            if newArticles.count == 0 {
                self.loadStatus = .done
            } else {
                guard case let .loading(page) = self.loadStatus else {
                    fatalError("loadSatus is in a bad state")
                }
                self.loadStatus = .ready(nextPage: page + 1)
            }
        }
    }
    
    func parseMoviesFromData(data: Data) -> [MovieItem] {
        var response: Movies
        do {
            response = try JSONDecoder().decode(Movies.self, from: data)
        } catch {
            print("Error parsing the JSON: \(error)")
            return []
        }
        
        return response.items ?? []
    }
    
    enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
    
}
