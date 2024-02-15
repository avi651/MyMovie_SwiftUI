//
//  CoreDataManager.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import Foundation
import CoreData

class MoviePersistentController: ObservableObject {
    
    var persistentContainer = NSPersistentContainer(name: "MoviesData")
    private var moviesFetchRequest = MoviesData.fetchRequest()
    
    init() {
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("error = \(error)")
            }
        }
    }
    
    func saveMovieData(_ movies: Movie) {
        let context = persistentContainer.viewContext
        //for movie in movies {
        let newMovie = NSEntityDescription.insertNewObject(forEntityName: "MoviesData", into: context)
        newMovie.setValue(movies.id, forKey: "id")
        newMovie.setValue(movies.adult, forKey: "adult")
        newMovie.setValue(movies.backDropPath, forKey: "backDropPath")
        newMovie.setValue(movies.originalLanguage, forKey: "originalLanguage")
        newMovie.setValue(movies.originalTitle, forKey: "originalTitle")
        newMovie.setValue(movies.overview, forKey: "overview")
        newMovie.setValue(movies.popularity, forKey: "popularity")
        newMovie.setValue(movies.posterPath, forKey: "posterPath")
        newMovie.setValue(movies.releaseDate, forKey: "releaseDate")
        newMovie.setValue(movies.title, forKey: "title")
        newMovie.setValue(movies.video, forKey: "video")
        newMovie.setValue(movies.voteAverage, forKey: "voteAverage")
        newMovie.setValue(movies.voteCount, forKey: "voteCount")
        // Save all the attributes in this way against its respective keys as I have done above.
        // }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    
    func updateAndAddServerDataToCoreData(moviesFromBackend: [Movie]?) {
        // 0. prepare incoming server side movies ID list and dictionary
        var moviesIdDict: [Int: Movie] = [:]
        var moviesIdList: [Int] = []
        
        guard let movies = moviesFromBackend,
              !movies.isEmpty else {
            return
        }
        
        for movie in movies {
            moviesIdDict[movie.id] = movie
        }
        moviesIdList = movies.map { $0.id }
        
        // 1. get all movies that match incoming server side movie ids
        // find any existing movies in our local CoreData
        moviesFetchRequest.predicate = NSPredicate(
            format: "id IN %@", moviesIdList
        )
        
        // 2. make a fetch request using predicate
        let managedObjectContext = persistentContainer.viewContext
        
        let moviesCDList = try? managedObjectContext.fetch(moviesFetchRequest)
        print("moviesCDList = \(String(describing: moviesCDList))")
        
        guard let moviesCDList = moviesCDList else {
            return
        }
        
        var moviesIdListInCD: [Int] = []
        
        // 3. update all matching movies from CoreData to have the same data
        // server side movies
        for movieCD in moviesCDList {
            moviesIdListInCD.append(Int(movieCD.id))
            
            if let movie = moviesIdDict[Int(movieCD.id)] {
                movieCD.setValue(movie.overview,
                                 forKey: "overview")
                movieCD.setValue(movie.title,
                                 forKey: "title")
                movieCD.setValue(movie.posterPath,
                                 forKey: "imageUrlSuffix")
                movieCD.setValue(movie.releaseDate,
                                 forKey: "releaseDate")
            }
        }
        
        // 4. add new objects coming from the backend/server side
        //        for movie in movies {
        //            if !moviesIdListInCD.contains(movie.id) {
        //                let genreCD = GenreCD(context: managedObjectContext)
        //                genreCD.id = 1
        //                genreCD.title = "Comedy"
        //
        //                let movieCD = MovieCD(context: managedObjectContext)
        //                movieCD.id = Int64(movie.id)
        //                movieCD.overview = movie.overview
        //                movieCD.releaseDate = movie.releaseDate
        //                movieCD.imageUrlSuffix = movie.posterPath
        //                movieCD.genre = genreCD
        //            }
        //        }
        
        // 5. save changes
        try? managedObjectContext.save()
    }
    
    func fetchMoviesFromCoreData() -> [Movie] {
        
        _ = NSSortDescriptor(key: "title",
                             ascending: false)
        let movieReleaseDateSortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        moviesFetchRequest.sortDescriptors = [movieReleaseDateSortDescriptor]
        
        
        let moviesCDList = try? persistentContainer.viewContext.fetch(moviesFetchRequest)
        var convertedMovies: [Movie] = []
        
        guard let moviesCDList = moviesCDList else {
            return []
        }
        
        for movieCD in moviesCDList {
            let movie = Movie(adult: false, backDropPath: "", id: Int(movieCD.id), originalLanguage: "", originalTitle: "", overview: movieCD.overview ?? "", popularity: 0.0, posterPath:  movieCD.posterPath ?? "", releaseDate: movieCD.releaseDate ?? "", title: movieCD.title ?? "", video: false, voteAverage: 0.0, voteCount: 0.0)
            convertedMovies.append(movie)
        }
        
        return convertedMovies
    }
    
}

