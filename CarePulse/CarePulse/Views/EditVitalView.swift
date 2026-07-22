//
//  EditVitalView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/22/26.
//

import SwiftUI
import CoreData

struct EditVitalView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var vital: VitalEntry
    
    @State private var date: Date
    @State private var heartRate: String
    @State private var systolicPressure: String
    @State private var diastolicPressure: String
    @State private var errorMessage = ""
    
    init(vital: VitalEntry) {
        self.vital = vital
        
        _date = State(initialValue: vital.date ?? Date())
        _heartRate = State(initialValue: String(vital.heartRate))
        _systolicPressure = State(initialValue: String(vital.systolicPressure))
        _diastolicPressure = State(initialValue: String(vital.diastolicPressure))
    }
    
    
    var body: some View {
        Form{
            Section("Vital Information") {
                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                
                TextField("Heart Rate", text: $heartRate)
                    .keyboardType(.numberPad)
                
                TextField("Systolic Pressure", text: $systolicPressure)
                    .keyboardType(.numberPad)
                
                TextField("Diastolic Pressure", text: $diastolicPressure)
                    .keyboardType(.numberPad)
                
            }
            
            if !errorMessage.isEmpty{
                Section{
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
            
            Section{
                Button("Save Changes") {
                    saveChanges()
                }
            }
        }
        .navigationTitle("Edit Vital")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveChanges() {
        guard
            let heartRateValue = Int16(heartRate),
            let systolicValue = Int16(systolicPressure),
            let diastolicValue = Int16(diastolicPressure)
        else {
            errorMessage = "Enter a valid number for all fields"
            return
        }
        vital.date = date
        vital.heartRate = heartRateValue
        vital.systolicPressure = systolicValue
        vital.diastolicPressure = diastolicValue
        
        do{
            try viewContext.save()
            dismiss()
        } catch {
            errorMessage = "The vital record could not be updated"
        }
    }
}


#Preview {
    let context = PersistenceController.preview.container.viewContext
    let vital = VitalEntry(context: context)
    
    vital.id = UUID()
    vital.date = Date()
    vital.heartRate = 72
    vital.systolicPressure = 120
    vital.diastolicPressure = 80
    
    
    return NavigationStack{
        EditVitalView(vital: vital)
            .environment(\.managedObjectContext, context)
    }
    
}
