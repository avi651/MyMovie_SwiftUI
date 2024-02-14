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
    var body: some View {
        NavigationView {
            if networkMonitor.isConnected {
                List {
                    Section(header: Text("Popular Movies")){
                        ForEach(popularMoviesViewModel.movies) { movie in
                            Text(movie.title)
                        }
                    }
                }.navigationTitle("Discover Movies").onAppear() {
                    popularMoviesViewModel.loadData()
                }
            } else {
                RetryNetworkView(retry: popularMoviesViewModel.loadData)
            }
        }

    }
}

#Preview {
    DiscoverView()
}
