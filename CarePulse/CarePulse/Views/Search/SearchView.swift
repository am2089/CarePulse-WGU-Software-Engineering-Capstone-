//
//  SearchView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/25/26.
//

import SwiftUI
import CoreData

struct SearchView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \SymptomEntry.date, ascending: false)])
    private var symptoms: FetchedResults<SymptomEntry>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MedicationEntry.name, ascending: true)])
    private var medications: FetchedResults<MedicationEntry>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \AppointmentEntry.date, ascending: false)])
    private var appointments: FetchedResults<AppointmentEntry>
    
    @State private var searchText = ""
    
    private var matchingSymptoms: [SymptomEntry] {
        symptoms.filter { symptom in symptom.symptom?.localizedCaseInsensitiveContains(searchText) == true
            
        }
    }
    
    private var matchingMedicaitons: [MedicationEntry] {
        medications.filter{ medication in
            medication.name?.localizedCaseInsensitiveContains(searchText) == true ||
            medication.dosage?.localizedCaseInsensitiveContains(searchText) == true ||
            medication.schedule?.localizedCaseInsensitiveContains(searchText) == true
        }
    }
    
    private var matchingAppointments: [AppointmentEntry] { appointments.filter{ appointment in
        appointment.provider?.localizedCaseInsensitiveContains(searchText) == true ||
        appointment.location?.localizedCaseInsensitiveContains(searchText) == true
        
        
        }
    }
    
    private var hasResults: Bool {
        !matchingSymptoms.isEmpty ||
        !matchingMedicaitons.isEmpty ||
        !matchingAppointments.isEmpty
    }
    
    
    
    
    var body: some View {
        NavigationStack {
            Group{
                if searchText.isEmpty {
                    ContentUnavailableView("Search CarePulse", systemImage: "magnifyingglass",
                                           description: Text("Search Symptoms, medications, providers, and locations"))
                } else if !hasResults {
                    ContentUnavailableView.search(text: searchText)
                } else {
                    List{
                        if !matchingSymptoms.isEmpty {
                            Section("Symptoms") {
                                ForEach(matchingSymptoms) {
                                    symptom in
                                    VStack(alignment: .leading, spacing: 4){
                                        Text(symptom.symptom ?? "Unknown Symptom"
                                        ).fontWeight(.bold)
                                        
                                        Text(symptom.date ?? Date(), style: .date).font(.caption).foregroundStyle(.secondary)
                                        
                                    }
                                }
                            }
                        }
                        
                        if !matchingMedicaitons.isEmpty {
                            Section("Medications") {
                                ForEach(matchingMedicaitons) {
                                    medication in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(medication.name ?? "Unknown Medication"
                                        )
                                        .fontWeight(.bold)
                                        
                                        Text("\(medication.dosage ?? "") - \(medication.schedule ?? "")"
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                        
                        if !matchingAppointments.isEmpty {
                            Section("Appointments") {
                                ForEach(matchingAppointments) { appointment in
                                    VStack(alignment: .leading, spacing: 4){
                                        Text(appointment.provider ?? "Unknown Provider").fontWeight(.bold)
                                        Text(appointment.location ?? "Unknown Location").font(.caption).foregroundStyle(.secondary)
                                        
                                        
                                        
                                    }
                                    
                                }
                            }
                        }
                        
                        
                        
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search records")
        }
        .toolbar(.visible, for: .navigationBar)
        
    }
}

#Preview {
    SearchView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
