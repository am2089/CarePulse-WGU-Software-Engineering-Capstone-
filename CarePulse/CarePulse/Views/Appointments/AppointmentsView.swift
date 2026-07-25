//
//  AppointmentsView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/19/26.
//

import SwiftUI
import CoreData

struct AppointmentsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \AppointmentEntry.date, ascending: false)
        ],
        animation: .default
    )
    private var appointments: FetchedResults<AppointmentEntry>
    
    
    
    var body: some View {
        VStack(spacing: 20){
            
            Text("Appointments")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            NavigationLink {
                AddAppointmentView()
            } label: {
                Label("Add Appointment", systemImage: "plus")
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            
            if appointments.isEmpty {
                
                Spacer()
                
                ContentUnavailableView("No Appointment Records", systemImage: "calendar", description: Text("Add an appointment to get started"))
                
                
                Spacer()
                
            } else {
                
                List {
                    ForEach(appointments) { appointment in
                        
                        NavigationLink {
                            EditAppointmentView(appointment: appointment)
                        } label: {
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text(appointment.provider ?? "Unknown provider")
                                    .fontWeight(.bold)
                                
                                Text(appointment.location ?? "Unknown location")
                                    .font(.subheadline)
                                
                                Text(appointment.date ?? Date(), style: .date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: deleteAppointments)
                }
                .listStyle(.plain)
            }
        }
        .padding()
    }
    
    private func deleteAppointments(offsets: IndexSet) {
        withAnimation{
            offsets.map { appointments[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print("Could not delete appointment: \(error.localizedDescription)")
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        AppointmentsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
