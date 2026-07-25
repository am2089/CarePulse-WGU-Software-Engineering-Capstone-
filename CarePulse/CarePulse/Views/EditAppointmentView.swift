//
//  EditAppointmentView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/25/26.
//

import SwiftUI
import CoreData

struct EditAppointmentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var appointment: AppointmentEntry
    
    @State private var date: Date
    @State private var provider: String
    @State private var location: String
    @State private var errorMessage = ""
    
    init(appointment: AppointmentEntry) {
        self.appointment = appointment
        
        _date = State(initialValue: appointment.date ?? Date())
        _provider = State(initialValue: appointment.provider ?? "")
        _location = State(initialValue: appointment.location ?? "")
    }
    
    
    var body: some View {
        Form{
            Section("Appointment Information") {
                DatePicker("Date and Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                
                TextField("Provider", text: $provider)
                TextField("Location", text: $location)
            }
            
            if !errorMessage.isEmpty {
                Section{
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
            
            Section {
                Button("Save Changes"){
                    saveChanges()
                }
            }
        }
        .navigationTitle("Edit Appointment")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveChanges() {
        let trimmedProvider = provider.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLocation = location.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedProvider.isEmpty, !trimmedLocation.isEmpty else {
            errorMessage = "Complete all appointment fields."
            return
        }
        
        appointment.date = date
        appointment.provider = trimmedProvider
        appointment.location = trimmedLocation
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            errorMessage = "The appointment could not be update"
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let appointment = AppointmentEntry(context: context)
    
    appointment.id = UUID()
    appointment.date = Date()
    appointment.provider = "Dr.Smith"
    appointment.location = "Cardiology Office"
    
    return NavigationStack{
        EditAppointmentView(appointment: appointment).environment(\.managedObjectContext, context)
    }
}
