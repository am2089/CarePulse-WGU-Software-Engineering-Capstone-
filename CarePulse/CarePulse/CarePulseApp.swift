//
//  CarePulseApp.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/14/26.
//

import SwiftUI

@main
struct CarePulseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LogInView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
