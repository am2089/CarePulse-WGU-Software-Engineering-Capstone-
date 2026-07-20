//
//  VitalsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/17/26.
//

import SwiftUI

struct VitalsView: View {
    var body: some View {
        VStack(spacing: 20){
            
            Text("Vitals")
                .font(.largeTitle)
                .fontWeight(.bold)
                
            Button{
                
            } label: {
                Label("Add Vital", systemImage: "plus")
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            
            Spacer()
            
            ContentUnavailableView(
                "No Vital Records", systemImage: "heart.text.square",
                description: Text("Add a vital record to get started")
            )
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Vitals")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        VitalsView()
    }
}
