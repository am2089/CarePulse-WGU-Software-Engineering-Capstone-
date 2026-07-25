//
//  HealthRecordSummary.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/25/26.
//

import Foundation

class HealthRecordSummary: Identifiable {
    
    let id = UUID()
    let title: String
    let count: Int
    
    init(title: String, count: Int) {
        self.title = title
        self.count = count
    }
    
    func summaryText() -> String {
        "\(count) records"
    }
}

class VitalRecordSummary: HealthRecordSummary {
    
    init(count: Int) {
        super.init(title: "Vital Records", count: count)
    }
    
    override func summaryText() -> String {
        "\(count) vital entries recorded"
    }
}

class SymptomRecordSummary: HealthRecordSummary {
    init(count: Int) {
        super.init(title: "Symptoms Records", count: count)
    }
    
    override func summaryText() -> String {
        "\(count) symptom entries recorded"
    }
}

class MedicationRecordSummary: HealthRecordSummary {
    
    init(count: Int) {
        super.init(title: "Medications", count: count)
    }
    
    override func summaryText() -> String {
        "\(count) medications recorded"
    }
}
    class AppointmentRecordSummary: HealthRecordSummary {
        
        init(count: Int) {
            super.init(title: "Appointments", count: count)
        }
        
        override func summaryText() -> String {
            "\(count) appointments recorded"
        }
        
        
    }
    
    
    




