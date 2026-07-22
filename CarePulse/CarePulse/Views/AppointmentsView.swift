//
//  AppointmentsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/19/26.
//

import SwiftUI

struct AppointmentsView: View {
    var body: some View {
        VStack(spacing: 20){
            
            Text("Appointments")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button{
                
            } label: {
                Label("Add appointments", systemImage: "plus")
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            
            Spacer()
            
            ContentUnavailableView(
                "No appointment records",
                systemImage: "calendar",
                description: Text("Add an appointment to get started.")
            )
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AppointmentsView()
    }
}
