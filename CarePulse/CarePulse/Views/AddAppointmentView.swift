//
//  AddAppointmentView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/25/26.
//

import SwiftUI
import CoreData

struct AddAppointmentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var date = Date()
    @State private var provider = ""
    @State private var location = ""
    @State private var errorMessage = ""
    
    var body: some View {
        
        Form{
            Section("Appointment Information") {
               
                DatePicker(
                    "Date and Time",
                    selection: $date,
                    displayedComponents: [.date, .hourAndMinute]
                )
                
                TextField("Provider", text: $provider)
                TextField("Location", text: $location)
            }
            
            if !errorMessage.isEmpty {
                Section {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
            
            Section {
                Button("Save Appointment") {
                    saveAppointment()
                }
            }
            
        }
        .navigationTitle("Add Appointment")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveAppointment() {
        let trimmedProvider = provider.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLocation = location.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        guard !trimmedProvider.isEmpty,
              !trimmedLocation.isEmpty
        else {
            errorMessage = "Complete all appointment fields"
            return
        }
        
        let appointment = AppointmentEntry(context: viewContext)
        appointment.id = UUID()
        appointment.date = date
        appointment.provider = trimmedProvider
        appointment.location = trimmedLocation
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            errorMessage = "The appoinment could not be saved."
        }
    }
}

#Preview {
    NavigationStack {
        AddAppointmentView()
            .environment((\.managedObjectContext), PersistenceController.preview.container.viewContext)
    }
}
