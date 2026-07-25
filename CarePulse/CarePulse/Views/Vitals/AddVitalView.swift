//
//  AddVitalView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/20/26.
//

import SwiftUI
import CoreData

struct AddVitalView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var date = Date()
    @State private var heartRate = ""
    @State private var systolicPressure = ""
    @State private var diastolicPressure = ""
    @State private var errorMessage = ""
    
    
    var body: some View {
        Form {
            
            Section("Vital Information") {
                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
            
            
            TextField("Heart Rate", text: $heartRate)
                .keyboardType(.numberPad)
            
            TextField("Systolic Pressure", text: $systolicPressure)
                .keyboardType(.numberPad)
            
            TextField("Diastolic Pressure", text: $diastolicPressure)
                .keyboardType(.numberPad)
        }
        
        if !errorMessage.isEmpty {
            Section {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
        }
        
        Section{
            Button("Save Vital") {
                saveVital()
            }
        }
        
    }
    .navigationTitle("Add Vital")
    .navigationBarTitleDisplayMode(.inline)
}

private func saveVital() {
    guard
        let heartRateValue = Int16(heartRate),
        let systolicValue = Int16(systolicPressure),
        let diastolicValue = Int16(diastolicPressure)
    else {
        errorMessage = "Enter valid numbers for all fields."
        return
    }
    
    let newVital = VitalEntry(context: viewContext)
    newVital.id = UUID()
    newVital.date = date
    newVital.heartRate = heartRateValue
    newVital.systolicPressure = systolicValue
    newVital.diastolicPressure = diastolicValue
    
    do {
        try viewContext.save()
        dismiss()
    } catch {
        errorMessage = "The vital record could not be saved"
    }
}
        
}

#Preview {
    NavigationStack{
        AddVitalView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
