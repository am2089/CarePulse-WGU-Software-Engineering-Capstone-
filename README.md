# CarePulse

An iOS health journal for organizing vital signs, symptoms, medications, and appointments in one place. Built with **Swift, SwiftUI, and Core Data** as my software engineering capstone at Western Governors University.

## Overview

Keeping personal health records across notes and separate lists can make them difficult to review. CarePulse provides a single interface for manually recording health information, updating entries, searching records, and viewing a summary of saved information.

## Features

- **Vital signs:** Record systolic and diastolic blood pressure, heart rate, and the date of each entry.
- **Symptom journal:** Add dated symptom entries and review previous records.
- **Medications:** Track medication names, dosages, and schedules.
- **Appointments:** Organize provider names, locations, and appointment dates.
- **Record management:** Create, view, edit, and delete entries across all four categories.
- **Search:** Find symptoms, medications, providers, and locations using case-insensitive text matching.
- **Reports:** View record counts and summary text for each category, with a report-generation timestamp.
- **Local persistence:** Store records using Core Data so entries remain available between launches.

## Technology

| Technology | Role |
| --- | --- |
| Swift | Application logic and record-summary models |
| SwiftUI | Forms, navigation, lists, search, and application state |
| Core Data | Local storage for health records |
| Swift Testing | Unit tests for report-summary behavior |
| XCTest | UI launch and performance test scaffolding |
| Git | Version control |

## Code Organization

- `CarePulse/CarePulse/Views/` — SwiftUI screens organized by feature, including vital signs, symptoms, medications, appointments, search, and reports.
- `CarePulse/CarePulse/Services/Persistence.swift` — Core Data container and persistence configuration.
- `CarePulse/CarePulse/CarePulse.xcdatamodeld/` — Data model containing the four health-record entities.
- `CarePulse/CarePulse/Views/Reports/HealthRecordSummary.swift` — Record-summary classes used by the reporting screen.
- `CarePulse/CarePulseTests/` — Unit tests for summary titles, counts, text, and subclass behavior.
- `CarePulse/CarePulseUITests/` — UI test targets.

The current implementation uses SwiftUI state, environment values, and Core Data fetch requests within feature views, with persistence configuration and report-summary models in separate files.

## Running the Project

### Requirements

- A Mac with Xcode 16 or later and an appropriate iOS SDK.
- An iPhone simulator or physical iPhone. The app target specifies iOS 17.0; test targets currently specify iOS 18.2, so an iOS 18.2 or newer simulator is the simplest choice for running both the app and tests.

### Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/am2089/CarePulse-WGU-Software-Engineering-Capstone-.git
   ```

2. Open `CarePulse/CarePulse.xcodeproj` in Xcode.
3. Select the **CarePulse** scheme and an iPhone simulator.
4. Build and run with **Command + R**.
5. On the demo login screen, enter any nonempty username and password to open the app.

For a physical device, select your own development team under **Signing & Capabilities** before running.

## Trying the App

1. Add sample entries under Vital Signs, Symptoms, Medications, and Appointments.
2. Edit an entry and confirm its updated values appear in the list.
3. Search for a symptom, medication name, provider, or location.
4. Open Reports to review the record counts.
5. Relaunch the app to review the saved records.

## Tests

Open the project in Xcode and run **Product → Test** or press **Command + U**. The unit tests cover record summary output and polymorphic behavior. The UI targets include launch and performance scaffolding.

## Current Scope

CarePulse is a single user capstone prototype. Login and registration demonstrate form validation and navigation; they do not implement account authentication or separate users' records. Health information is entered manually and stored locally. Automated device imports, cloud synchronization, and report export are not implemented.

## Author

**Andrew Muniz** — [GitHub](https://github.com/am2089)
