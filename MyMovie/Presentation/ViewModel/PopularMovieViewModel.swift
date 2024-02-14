//
//  PopularMovieViewModel.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import Foundation
import Network
import CoreData

class PopularMoviesViewModel: ObservableObject {
    
    private var networkConnectivity = NWPathMonitor()
    
    @Published var movies: [Movie] = [Movie]()
    @Published var state: MovieFetchState = .good
    
    let service: MovieServiceProtocol
    
    init(apiService: MovieServiceProtocol = MovieUseCase(repo: MovieService())) {
        self.service = apiService
        networkConnectivity.start(queue: DispatchQueue.global(qos: .userInitiated))
    }
    
    internal func loadData() -> Void {
        fetchMovies()
    }
    
    private func fetchMovies() {
        switch networkConnectivity.currentPath.status {
        case .satisfied: // connected to internet
            guard state == MovieFetchState.good else {
                return
            }
            
            state = .isLoading
            
            service.fetchMovie { [weak self]  result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let results):
                        
                        self?.movies = results.results
                        
                        if results.results.count == 0 {
                            self?.state = .noResults
                        } else {
                            self?.state = .good
                        }
                        print("fetched movies \(results.results.count)")
                    case .failure(let error):
                        print("error loading movies: \(error)")
                        self?.state = .error(error.localizedDescription)
                    }
                }
            }
            
        default:
            print("Unable to fetch Data")
        }
    }
}
