//
//  DiscoverVieww.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject var popularMoviesViewModel = PopularMoviesViewModel()
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @EnvironmentObject var persistentController: MoviePersistentController
    
    var body: some View {
        NavigationView {
            if networkMonitor.isConnected {
                NavigationStack {
                    List {
                        Section(header: Text("Popular Movies")){
                            ForEach(popularMoviesViewModel.movies) { movie in
                                MovieHorizontalCardView(movieTitle: movie.title, movieDate: "23", movieBackgroundImage : movie.posterURL)
                                Text(movie.title).onTapGesture {
                                    // do something here
                                    print("Tapped Menu")
                                    print(movie)
                                    self.persistentController.saveMovieData(movie)
                                }
                            }
                        }
                    }.navigationTitle("Discover Movies").onAppear() {
                        popularMoviesViewModel.loadData()
                    }
                }
            } else {
                RetryNetworkView(retry: popularMoviesViewModel.loadData)
            }
        }
        
    }
}


//#Preview {
//    DiscoverView()
//}
