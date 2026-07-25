//
//  ReportsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/25/26.
//

import SwiftUI
import CoreData

struct ReportsView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var vitals: FetchedResults<VitalEntry>
    
    @FetchRequest(sortDescriptors: [])
    private var symptoms: FetchedResults<SymptomEntry>
    
    @FetchRequest(sortDescriptors: [])
    private var medications: FetchedResults<MedicationEntry>
    
    @FetchRequest(sortDescriptors: [])
    private var appointments: FetchedResults<AppointmentEntry>
    
    
    
    
    var body: some View {
        VStack(spacing: 24) {
            
        Text("Reports")
            .font(.largeTitle)
            .fontWeight(.bold)
        
        ReportRow(
            title: "Vital Records",
            count: vitals.count,
            systemImage: "heart.text.clipboard"
        )
        
        ReportRow(
            title: "Symptom Records",
            count: symptoms.count,
            systemImage: "waveform.path.ecg"
        )
        
        ReportRow(
            title: "Medications",
            count: medications.count,
            systemImage: "pills"
        )
        
        ReportRow(
            title: "Appointments",
            count: appointments.count,
            systemImage: "calendar"
        )
        
        Spacer()
        
    }
        .padding()
        
    }
        
}

struct ReportRow: View {
    let title: String
    let count: Int
    let systemImage: String
    
    var body: some View {
        HStack(spacing: 16) {
            
            Image(systemName: systemImage)
                .font(.title2)
                .frame(width: 40)
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Text("\(count)")
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding()
        .background(.gray.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
}

#Preview {
    NavigationStack{
        ReportsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
