//
//  AddSymptomView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/24/26.
//

import SwiftUI
import CoreData

struct AddSymptomView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var date = Date()
    @State private var symptom = ""
    @State private var errorMessage = ""
    
    var body: some View {
        
        Form{
            Section("Symptom Information") {
                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                TextField("Symptom", text: $symptom, axis: .vertical)
                    .lineLimit(3...6)
            }
            
            if !errorMessage.isEmpty {
                Section {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
            
            Section {
                Button("Save symptom") {
                    saveSymptom()
                }
            }
            
        }
        .navigationTitle("Add Symptom")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveSymptom() {
        let trimmedSymptom = symptom.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedSymptom.isEmpty else {
            errorMessage = "Enter a symptom."
            return
        }
        
        let newSymptom = SymptomEntry(context: viewContext)
        newSymptom.id = UUID()
        newSymptom.date = date
        newSymptom.symptom = trimmedSymptom
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            errorMessage = "The symptom could not be saved."
        }
    }
}

#Preview {
    NavigationStack {
        AddSymptomView()
            .environment((\.managedObjectContext), PersistenceController.preview.container.viewContext)
    }
}
