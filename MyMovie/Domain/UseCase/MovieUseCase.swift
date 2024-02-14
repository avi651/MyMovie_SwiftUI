//
//  MovieUseCase.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import Foundation

struct MovieUseCase : MovieServiceProtocol {
    
    var repo : MovieService
    
    init(repo: MovieService) {
        self.repo = repo
    }
    
    public func fetchMovie(completion: @escaping (Result<MovieResult, MovieAPIError>) -> Void) {
        let url = repo.getMovies()
        MovieNetworkService.fetch(type: MovieResult.self, url: url, httpMethod: "GET", completion: completion)
    }
}
