//
//  CarePulseTests.swift
//  CarePulseTests
//
//  Created by Andrew Muniz on 7/14/26.
//

import Testing
@testable import CarePulse

struct CarePulseTests {

    @Test func vitalRecordSummaryReturnCorrectText() {
        let summary = VitalRecordSummary(count: 3)
        
        #expect(summary.title == "Vital Records")
        #expect(summary.count == 3)
        #expect(summary.summaryText() == "3 vital entries recorded")
    }
    
    @Test func symptomRecordSummaryReturnCorrectText() {
        let summary = SymptomRecordSummary(count: 2)
        
        #expect(summary.title == "Symptoms Records")
        #expect(summary.count == 2)
        #expect(summary.summaryText() == "2 symptom entries recorded")
    }
    
    @Test func polymorphismReturnSubclassSummaryText() {
        let summaries: [HealthRecordSummary] = [
            VitalRecordSummary(count: 1),
            MedicationRecordSummary(count: 4),
            AppointmentRecordSummary(count: 2)
        ]
        
        #expect(summaries[0].summaryText() == "1 vital entries recorded")
        #expect(summaries[1].summaryText() == "4 medications recorded")
        #expect(summaries[2].summaryText() == "2 appointments recorded")
    }

}
