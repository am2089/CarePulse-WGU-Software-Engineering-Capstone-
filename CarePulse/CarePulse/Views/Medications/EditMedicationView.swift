//
//  EditMedicationsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/24/26.
//

import SwiftUI
import CoreData

struct EditMedicationView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var medication: MedicationEntry
    
    @State private var name: String
    @State private var dosage: String
    @State private var schedule: String
    @State private var errorMessage = ""
    
    init(medication: MedicationEntry) {
        self.medication = medication
        _name = State(initialValue: medication.name ?? "")
        _dosage = State(initialValue: medication.dosage ?? "")
        _schedule = State(initialValue: medication.schedule ?? "")
    }
    
    
    var body: some View {
        Form {
            Section("Medication Information") {
                
                TextField("Medication Name", text: $name)
                TextField("Dosage", text: $dosage)
                TextField("Schedule", text: $schedule)
                
            }
            
            if !errorMessage.isEmpty {
                Section{
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
            
            Section {
                Button("Save Changes") {
                    saveChanges()
                }
            }
        }
        .navigationTitle("Edit Medication")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveChanges() {
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDosage = dosage.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedSchedule = schedule.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty,
              !trimmedDosage.isEmpty,
              !trimmedSchedule.isEmpty
        else {
            errorMessage = "Complete all medication fields."
            return
        }
        
        medication.name = trimmedName
        medication.dosage = trimmedDosage
        medication.schedule = trimmedSchedule
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            errorMessage = "The medication could not be updated"
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let medication = MedicationEntry(context: context)
    
    medication.id = UUID()
    medication.name = "Aspirin"
    medication.dosage = "81 mg"
    medication.schedule = "Once daily"
    
    return NavigationStack {
        EditMedicationView(medication: medication)
            .environment(\.managedObjectContext, context)
    }
    
    
    
}
