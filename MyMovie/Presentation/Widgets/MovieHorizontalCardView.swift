//
//  MovieHorizontalCardView.swift
//  MyMovie
//
//  Created by Avinash on 15/02/24.
//

import SwiftUI

struct MovieHorizontalCardView: View {
    @Environment(\.colorScheme) var colorScheme
    var movieTitle: String?
    var movieDate: String?
    var movieBackgroundImage: URL?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(self.colorScheme == .light ? Color.white : Color.black)
            .frame(height: 150)
            .shadow(radius: self.colorScheme == .light ? 20 : 0)
            .overlay(imageAndText(movieName: movieTitle ?? "" , movieDate: movieDate ?? ""))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding([.leading, .trailing])
    }
}

@ViewBuilder
private func imageAndText(movieName: String, movieDate: String) -> some View {
    VStack(spacing: 0) {
//        Image(movieImg)
//            .resizable()
//            .scaledToFill()
        
        HStack {
            VStack(alignment: .leading) {
                Text(movieName.uppercased())
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Lorem ipsum")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .padding([.vertical], 4)
                
                Text("Lorem ipsum dolor sit".uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .layoutPriority(1)
            

        }
        .padding()
    }
}

#Preview {
    MovieHorizontalCardView()
}
