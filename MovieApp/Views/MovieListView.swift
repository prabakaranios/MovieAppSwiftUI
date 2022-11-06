//
//  MovieListView.swift
//  MovieApp
//
//  Created by Prabakaran Kuppusamy on 30/07/21.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var movieListVM = MovieListViewModel()
    
    var body: some View {
        if movieListVM.count == 0 {
            VStack(alignment: .center) {
                Image("loading")
                    
            }
        }
        else {
            NavigationView {
                List(movieListVM) { (movieList: MovieItem) in
                    NavigationLink(destination: MovieDetailView(movieItem: movieList)) {
                        MoivieListItemListView(movieItem: movieList)
                            .onAppear {
                                self.movieListVM.loadMoreMovies(currentItem: movieList)
                            }
                            .accessibilityIdentifier("\(movieList.id)")
                    }
                }
                .navigationBarTitle("Popular Movies")
                .accessibilityIdentifier("movieListViewTitle")
            }
        }
    }
}

struct MoivieListItemListView: View {
    var movieItem: MovieItem

    var body: some View {
        HStack {
            UrlImageView(urlString: movieItem.url)
            VStack(alignment: .leading) {
                Text("\(movieItem.title)")
                    .font(.headline)
                    .lineLimit(1)
                Text("\(movieItem.overview)")
                    .font(.subheadline)
                    .lineLimit(2)
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}


