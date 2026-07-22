//
//  SymptomsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/19/26.
//

import SwiftUI

struct SymptomsView: View {
    var body: some View {
        VStack(spacing: 20){
            
            Text("Symptoms")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button{
                
            } label: {
                Label("Add symptom", systemImage: "plus")
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            
            Spacer()
            
            ContentUnavailableView(
                "No symptom records",
                systemImage: "waveform.path.ecg",
                description: Text("Add a symptom record to get started")
            )
            
            Spacer()
            
        }
        .padding()
      
    }
}

#Preview {
    NavigationStack {
        SymptomsView()
    }
}
