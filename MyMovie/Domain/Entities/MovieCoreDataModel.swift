//
//  MovieCoreDataModel.swift
//  MyMovie
//
//  Created by Avinash on 15/02/24.
//

import Foundation

enum MovieCoreDataStatus: String, CaseIterable {
    case pending
    case completed
}

struct MovieCoreDataModel: Codable {
    var results: [MovieOfflineModel]
}

// MARK: - Result
struct MovieOfflineModel: Codable, Identifiable {
    let adult: Bool
    let backDropPath: String
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Double
}
