//
//  MedicationsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/19/26.
//

import SwiftUI

struct MedicationsView: View {
    var body: some View {
        VStack(spacing: 20){
            
            Text("Medications")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button{
                
            } label: {
                Label("Add Medication", systemImage: "plus")
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            
            Spacer()
            
            ContentUnavailableView(
                "No Medication Records",
                systemImage: "pills",
                description: Text("Add a Medication record to get started")
            )
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Medications")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MedicationsView()
    }
}
