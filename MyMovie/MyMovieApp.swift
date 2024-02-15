//
//  MyMovieApp.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import SwiftUI
import CoreData

@main
struct MyMovieApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject private var persistentController: MoviePersistentController = MoviePersistentController()
    @AppStorage("appTheme") private var isDarkModeOn = false
    @AppStorage("fontSize") private var fontSize = 2.0
    
    var body: some Scene {
        WindowGroup {
            BottomTabBarView().preferredColorScheme(isDarkModeOn ? .dark : .light).environmentObject(networkMonitor).environmentObject(persistentController)
                .environment(\.managedObjectContext, persistentController.persistentContainer.viewContext)
        }
    }
}
