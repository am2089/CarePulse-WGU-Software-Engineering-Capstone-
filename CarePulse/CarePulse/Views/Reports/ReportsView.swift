//
//  ReportsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/25/26.
//

import SwiftUI
import CoreData

struct ReportsView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \VitalEntry.date, ascending: false)])
    private var vitals: FetchedResults<VitalEntry>
    
    @FetchRequest(sortDescriptors: [])
    private var symptoms: FetchedResults<SymptomEntry>
    
    @FetchRequest(sortDescriptors: [])
    private var medications: FetchedResults<MedicationEntry>
    
    @FetchRequest(sortDescriptors: [])
    private var appointments: FetchedResults<AppointmentEntry>
    
    private var reportRows: [HealthRecordSummary] {
        [
            VitalRecordSummary(count: vitals.count),
            SymptomRecordSummary(count: symptoms.count),
            MedicationRecordSummary(count: medications.count),
            AppointmentRecordSummary(count: appointments.count)
        ]
    }
    
    private var reportDate: Date {
        Date()
    }
    
    var body: some View{
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("CarePulse Record Report")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Generated \(reportDate.formatted(date: .abbreviated, time: .shortened))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack{
                    Text("Category")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("Record Count")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("Summary")
                        .fontWeight(.bold)
                }
                .font(.caption)
                .padding(.horizontal)
                
                List(reportRows) { report in
                    HStack(alignment: .top, spacing: 12) {
                        Text(report.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(report.count)")
                            .frame(width: 70)
                        
                        Text(report.summaryText())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.secondary)
                            
                        
                    }
                    .font(.subheadline)
                    
                }
                .listStyle(.plain)
                
                
            }
            .padding()
            .navigationTitle("Reports")
        }
    }
  
        
}



#Preview {
    NavigationStack{
        ReportsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
