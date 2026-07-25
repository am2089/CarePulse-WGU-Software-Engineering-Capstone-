//
//  EditSymptomView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/24/26.
//

import SwiftUI
import CoreData

struct EditSymptomView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var symptom: SymptomEntry
    
    @State private var date: Date
    @State private var symptomText: String
    @State private var errorMessage = ""
    
    init(symptom: SymptomEntry) {
        self.symptom = symptom
        _date = State(initialValue: symptom.date ?? Date())
        _symptomText = State(initialValue: symptom.symptom ?? "")
    }
    
    
    var body: some View {
        Form {
            Section("Symptom Information") {
                DatePicker("Date", selection: $date,displayedComponents: [.date, .hourAndMinute])
                
                TextField("Symptom", text: $symptomText, axis: .vertical) .lineLimit(3...6)
                
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
        .navigationTitle("Edit Symptom")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveChanges() {
        let trimmedSymptom = symptomText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedSymptom.isEmpty else {
            errorMessage = "Enter a symptom"
            return
        }
        
        symptom.date = date
        symptom.symptom = trimmedSymptom
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            errorMessage = "The symptom record could not be updated"
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let symptom = SymptomEntry(context: context)
    
    symptom.id = UUID()
    symptom.date = Date()
    symptom.symptom = "Chest discomfort"
    
    return NavigationStack {
        EditSymptomView(symptom: symptom)
            .environment(\.managedObjectContext, context)
    }
    
    
    
}
