//
//  CoreDataUseCase.swift
//  MyMovie
//
//  Created by Avinash on 15/02/24.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataUseCase {
    // MARK: Core data variables
    @Environment(\.managedObjectContext) var viewContext
    @Published var movieOffline: MoviesData?
    
    public func saveMovie(  backDropPath: String, id: Int, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Double){
        
        if movieOffline == nil {
            movieOffline = MoviesData(context: self.viewContext)
            movieOffline?.id = Int64(id)
        }
        movieOffline?.backDropPath = backDropPath
        movieOffline?.originalLanguage = originalLanguage
        movieOffline?.originalTitle = originalTitle
        movieOffline?.overview = overview
        movieOffline?.popularity = popularity
        movieOffline?.posterPath = posterPath
        movieOffline?.releaseDate = releaseDate
        movieOffline?.title = title
        movieOffline?.video = video
        movieOffline?.voteAverage = voteAverage
        movieOffline?.voteCount = voteCount
        
        do {
            try self.viewContext.save()
            print("Movie CoreData Saved")
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
}

