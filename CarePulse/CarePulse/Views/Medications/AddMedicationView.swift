//
//  AddMedicationView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/24/26.
//

import SwiftUI
import CoreData

struct AddMedicationView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var dosage = ""
    @State private var schedule = ""
    @State private var errorMessage = ""
    
    var body: some View {
        
        Form{
            Section("Medication Information") {
               
                TextField("Medication Information", text: $name)
                TextField("Dosage", text: $dosage)
                TextField("Schedule", text: $schedule)
            }
            
            if !errorMessage.isEmpty {
                Section {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
            
            Section {
                Button("Save Medication") {
                    saveMedication()
                }
            }
            
        }
        .navigationTitle("Add Medication")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveMedication() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDosage = dosage.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedSchedule = schedule.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty,
        !trimmedDosage.isEmpty,
        !trimmedSchedule.isEmpty
        else {
            errorMessage = "Complete all medication fields"
            return
        }
        
        let medication = MedicationEntry(context: viewContext)
        medication.id = UUID()
        medication.name = trimmedName
        medication.dosage = trimmedDosage
        medication.schedule = trimmedSchedule
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            errorMessage = "The medication could not be saved."
        }
    }
}

#Preview {
    NavigationStack {
        AddMedicationView()
            .environment((\.managedObjectContext), PersistenceController.preview.container.viewContext)
    }
}
