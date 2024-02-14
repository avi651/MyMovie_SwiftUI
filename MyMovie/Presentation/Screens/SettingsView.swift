//
//  SettingsView.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("appTheme") var isDarkModeOn: Bool = false
    @State private var profileImageSize = false
    @AppStorage("fontSize") var fontSize = 2.0
    
    var body: some View {
        List {
            Section {
                Toggle("Theme", isOn: $isDarkModeOn)
            } header: { Text("Profile") }
            
            Section {
                Slider(value: $fontSize, in: 1...10) {
                    Label("Default Font Size", systemImage: "text.magnifyingglass")
                }
                
            } header: {  }
            
            Section {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("2.2.1")
                }
            } header: { Text("ABOUT") }
        }
    }
}

#Preview {
    SettingsView()
}
