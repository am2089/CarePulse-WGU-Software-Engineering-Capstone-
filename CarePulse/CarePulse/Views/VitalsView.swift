//
//  VitalsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/17/26.
//

import SwiftUI
import CoreData

struct VitalsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \VitalEntry.date, ascending: false)
        ],
        animation: .default
    )
    private var vitals: FetchedResults<VitalEntry>
    
    
    
    var body: some View {
        VStack(spacing: 20){
            
            Text("Vitals")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            NavigationLink {
                AddVitalView()
            } label: {
                Label("Add Vital", systemImage: "plus")
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            
            if vitals.isEmpty{
                
                Spacer()
                
                ContentUnavailableView(
                    "No Vital Records", systemImage: "heart.text.square",
                    description: Text("Add a vital record to get started")
                )
                
                Spacer()
                
            } else {
                List {
                    ForEach(vitals) {vital in
                        NavigationLink{
                            EditVitalView(vital: vital)
                        } label: {
                            
                            
                            VStack(alignment: .leading, spacing: 6){
                                Text("Heart Rate: \(vital.heartRate) BPM")
                                    .fontWeight(.bold)
                                
                                Text(
                                    "Blood Pressure: \(vital.systolicPressure)/\(vital.diastolicPressure)"
                                )
                                
                                Text(vital.date ?? Date(), style: .date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: deleteVitals)
                }
                .listStyle(.plain)
                
            }
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
        
    }
    
    private func deleteVitals(offsets: IndexSet) {
        withAnimation {
            offsets.map { vitals[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print("Could not delete vital record: \(error.localizedDescription)")
                
                }
            }
        }
    }



#Preview {
    NavigationStack{
        VitalsView()
    }
}
