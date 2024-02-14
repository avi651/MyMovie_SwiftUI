//
//  MovieFetchState.swift
//  TheMovie
//
//  Created by Avinash on 14/02/24.
//

import Foundation

enum MovieFetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case noResults
    case error(String)
}
