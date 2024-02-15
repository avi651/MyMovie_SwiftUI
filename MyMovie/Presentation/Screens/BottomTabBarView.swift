//
//  ContentView.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import SwiftUI

struct BottomTabBarView: View {
 
    var body: some View {
        TabView {
            DiscoverView().tabItem {
             VStack {
                Image(systemName: "opticaldisc")
                Text("Discover")
               }
           }.tag(0)
            ArtistView().tabItem {
               VStack {
                  Image(systemName: "figure.martial.arts")
                  Text("Artists")
                 }
           }.tag(1)
            FavoriteView().tabItem {
                VStack {
                   Image(systemName: "star.fill")
                   Text("Favorite")
                  }
            }.tag(2)
            SettingsView().tabItem {
                VStack {
                   Image(systemName: "gear")
                   Text("Settings")
                  }
            }.tag(3)
        }
    }
}

//#Preview {
//    BottomTabBarView()
//}
