//
//  MovieNetworkRepository.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovie(completion: @escaping(Result<MovieResult, MovieAPIError>) -> Void)
}
