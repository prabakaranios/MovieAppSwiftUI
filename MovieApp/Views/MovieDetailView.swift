//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Prabakaran Kuppusamy on 30/07/21.
//

import SwiftUI
import URLImage

struct MovieDetailView: View {
    var movieItem: MovieItem
    
    @ObservedObject var movieDetailVM: MovieDetailViewModel
    
    init(movieItem: MovieItem) {
        self.movieItem = movieItem
        movieDetailVM = MovieDetailViewModel(movieId: movieItem.id)
        movieDetailVM.getMoviewDetail()
    }
    
    var body: some View {
        ScrollView {
            if let movieUrl = self.movieDetailVM.movieDetail.url{
                MovieImage(url: movieUrl)
            }
            VStack(alignment: .center) {
                if let title = self.movieDetailVM.movieDetail.title {
                    RowItem(grid1: "Title", grid2: title)
                }
                if let budget = self.movieDetailVM.movieDetail.totalBudget {
                    RowItem(grid1: "Budget", grid2: budget)
                }
                if let movieTime = self.movieDetailVM.movieDetail.movieTime {
                    RowItem(grid1: "Time", grid2: movieTime)
                    
                }
                if let releaseDate = self.movieDetailVM.movieDetail.releaseDate {
                    RowItem(grid1: "Release Date", grid2: releaseDate)
                    
                }
            }
        }.navigationBarTitle(Text(movieItem.title), displayMode: .inline)
    }
}

struct RowItem: View {
    var grid1:String
    var grid2:String
    
    var body: some View {
        Spacer()
        HStack {
            Text(grid1)
                .frame(width: 150, alignment: .leading)
                .font(.headline)
            Text(": " + (grid2))
                .frame(width: 150,alignment: .leading)
        }
    }
}

struct MovieImage: View {
    
    var url: String?
    
    var body: some View {
        if let url = URL(string: url ?? "") {
            URLImage(url,
                     empty: {
                        Image("loadingjpg")
                            .resizable()
                            .padding(.all,10)
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                     },
                     inProgress: { progress in
                        Image("loadingjpg")
                            .resizable()
                            .padding(.all,10)
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                     },
                     failure: { error, retry in
                        Image("failed")
                            .resizable()
                            .padding(.all,10)
                            .frame(width: UIScreen.main.bounds.width, height: 300)                     },
                     content: { image, info in
                        image
                            .resizable()
                            .padding(.all,10)
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                     })
        }
    }
}


struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let movieItem = MovieItem(id: 1, title: "avenger", overview: "actionmovie", path: "http://image.tmdb.org/t/p/w300/nkayOAUBUu4mMvyNf9iHSUiPjF1.jpg")
        MovieDetailView(movieItem: movieItem)
    }
}
