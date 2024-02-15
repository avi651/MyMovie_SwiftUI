//
//  FavoriteView.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import SwiftUI

struct FavoriteView: View {
    // Core Data
    //@EnvironmentObject var persistentController: MoviePersistentController
    @FetchRequest(sortDescriptors: []) private var movieTodos: FetchedResults<MoviesData>

    
    var body: some View {
        List {
            Section(header: Text("Popular Movies")){
                ForEach(movieTodos) { movie in
                    Text(movie.title ?? "")
                }
            }
        }
    }
}

//#Preview {
//    FavoriteView()
//}
