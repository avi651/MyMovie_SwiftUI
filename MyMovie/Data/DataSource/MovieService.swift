//
//  MovieService.swift
//  TheMovie
//
//  Created by Avinash on 14/02/24.
//

import Foundation

class MovieService {
    func getMovies() -> URL? {
        let baseURL = "\(MovieAPIConstants.baseURL)/popular"
        let queryItems = [URLQueryItem(name: "api_key", value: MovieAPIConstants.apiKey),
                          URLQueryItem(name: "language", value: MovieAPIConstants.languageLocale),
                          URLQueryItem(name: "page", value: "\(MovieAPIConstants.pageValue)")]
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
}
