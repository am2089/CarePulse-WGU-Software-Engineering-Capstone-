//
//  SettingsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/25/26.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section("About") {
                    VStack(alignment: .leading, spacing: 6) {
                    Text("CarePulse")
                        .font(.headline)
                    
                    Text("CarePulse helps users organize their cardiac recovery information, including vitals, symptoms, medications, and appointments.")
                }
                .padding(.vertical, 4)
            }
            
            Section("Application") {
                LabeledContent("Version", value: "1.0")
                
                LabeledContent("Data Storage", value: "Stored locally")
                
            }
            
            Section{
                Button("Log out", role: .destructive){
                    showingLogoutAlert = true
                }
            }
            
        }
        .navigationTitle("Settings")
        .alert("Log out?", isPresented: $showingLogoutAlert) {
            
                Button("Cancel", role: .cancel) {}
        
                Button("Log out", role: .destructive){
                    dismiss()
                }
            
            } message: {
                Text("Are you sure you want to return to the login screen?")
            }
        }
    }
}

#Preview {
    SettingsView()
}
