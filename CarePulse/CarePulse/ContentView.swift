//
//  ContentView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/14/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.text.clipboard")
                .font(.system(size: 60))
            
            
            Text("CarePulse")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Recovery Information Organizer")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
