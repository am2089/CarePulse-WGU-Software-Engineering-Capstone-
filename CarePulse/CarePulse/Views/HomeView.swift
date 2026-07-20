//
//  HomeView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/17/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    
                    Text("CarePulse")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Recovery Record Organizer")
                        .font(.title)
                        .foregroundStyle(.secondary)
                    
                    
                    NavigationLink{
                        VitalsView()
                    } label: {
                        HomeBlockButton(
                            title: "Vitals",
                            subtitle: "Record and review vital signs",
                            systemImage: "heart.text.square"
                        )
                    }
                    .buttonStyle(.plain)
                    
                    
                    NavigationLink{
                        SymptomsView()
                    } label: {
                        HomeBlockButton(
                            title: "Symptoms",
                            subtitle: "Track symptoms and descriptions",
                            systemImage: "waveform.path.ecg"
                        )
                    }
                    .buttonStyle(.plain)
                    
                    
                    NavigationLink{
                        MedicationsView()
                    } label: {
                        HomeBlockButton(
                            title: "Medications",
                            subtitle: "Manage medication records",
                            systemImage: "pills"
                        )
                    }
                    .buttonStyle(.plain)
                    
                    NavigationLink{
                        AppointmentsView()
                    } label: {
                        
                        HomeBlockButton(
                            title: "Appointments",
                            subtitle: "Manage upcoming appointments",
                            systemImage: "calendar"
                        )
                    }
                    .buttonStyle(.plain)
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct HomeBlockButton: View{
    let title: String
    let subtitle: String
    let systemImage: String
    
    var body: some View {
      HStack(spacing: 16) {
                Image(systemName: systemImage)
                    .font(.title)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
                
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 110)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color(.secondarySystemBackground))
            )
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(.separator), lineWidth: 1))
        
        
    }
        
    
    
    
    }




#Preview {
    HomeView()
}
