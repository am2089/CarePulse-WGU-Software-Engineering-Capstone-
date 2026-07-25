//
//  SymptomsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/19/26.
//

import SwiftUI
import CoreData

struct SymptomsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \SymptomEntry.date, ascending: false)
        ],
        animation: .default
    )
    private var symptoms: FetchedResults<SymptomEntry>
    
    
    
    var body: some View {
        VStack(spacing: 20){
            
            Text("Symptoms")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            NavigationLink {
                AddSymptomView()
            } label: {
                Label("Add Symptom", systemImage: "plus")
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            
            if symptoms.isEmpty{
                
                Spacer()
                
                ContentUnavailableView(
                    "No Symptom Records", systemImage: "waveform.path.ecg",
                    description: Text("Add a Symptom record to get started")
                )
                
                Spacer()
                
            } else {
                List {
                    ForEach(symptoms) {symptom in
                        
                        
                        NavigationLink {
                            EditSymptomView(symptom: symptom)
                        } label: {
                            VStack(alignment: .leading, spacing: 6){
                                Text(symptom.symptom ?? "Unknown Symptom")
                                    .fontWeight(.bold)
                                
                                Text(symptom.date ?? Date(), style: .date
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                
                            }
                            .padding(.vertical, 4)
                        }
                       
                    }
                    .onDelete(perform: deleteSymptoms)
                }
                .listStyle(.plain)
                
            }
        }
        .padding()
        
        
    }
    
    private func deleteSymptoms(offsets: IndexSet) {
        withAnimation {
            offsets.map { symptoms[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print("Could not delete symptom record: \(error.localizedDescription)")
                
                }
            }
        }
    }


#Preview {
    NavigationStack {
        SymptomsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

