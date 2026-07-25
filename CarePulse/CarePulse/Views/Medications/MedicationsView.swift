//
//  MedicationsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/19/26.
//

import SwiftUI
import CoreData

struct MedicationsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \MedicationEntry.name, ascending: true)
        ],
        animation: .default
    )
    private var medications: FetchedResults<MedicationEntry>
    
    
    
    var body: some View {
        VStack(spacing: 20){
            
            Text("Medications")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            NavigationLink {
                AddMedicationView()
            } label: {
                Label("Add Medication", systemImage: "plus")
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            
            if medications.isEmpty{
                
                Spacer()
                
                ContentUnavailableView(
                    "No Medication Records", systemImage: "pills",
                    description: Text("Add a medication record to get started")
                )
                
                Spacer()
                
            } else {
                List {
                    ForEach(medications) {medication in
                        NavigationLink{
                            EditMedicationView(medication: medication)
                        } label: {
                            VStack(alignment: .leading, spacing: 6){
                                Text(medication.name ?? "Unknown Medication")
                                    .fontWeight(.bold)
                                
                                Text("Dosage: \(medication.dosage ?? "Not provided")")
                                    .font(.subheadline)
                                
                                Text("Schedule: \(medication.schedule ?? "Not provided")")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                            }
                            .padding(.vertical, 4)
                            }
                       
                    }
                    .onDelete(perform: deleteMedications)
                }
                .listStyle(.plain)
                
            }
        }
        .padding()
    }
    
    private func deleteMedications(offsets: IndexSet) {
        withAnimation {
            offsets.map { medications[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print("Could not delete medication record: \(error.localizedDescription)")
                
                }
            }
        }
    }



#Preview {
    NavigationStack{
        MedicationsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
