//
//  RetryNetworkView.swift
//  MyMovie
//
//  Created by Avinash on 14/02/24.
//

import SwiftUI

struct RetryNetworkView: View {
    //internal var retry: ( @escaping () -> Void) -> Void
    
    let retry: () -> Void
    
    var body: some View {
        VStack {
//            Image(systemName: "wifi")
//                .resizable()
//            scaledToFit()
//                .frame(width: 200, height: 200)
//                .foregroundColor(.white)
            Text("It looks like you're not connected to the Internet. Make sure WIFI is enabled and try again.")
            Button(action: {
                self.retry()
            }, label: {
                Text("Retry")
                    .padding()
                    .font(.headline)
                    .foregroundColor(Color(.systemBlue))
            })
        }
    }
}

