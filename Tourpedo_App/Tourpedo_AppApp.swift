//
//  Tourpedo_AppApp.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/15/24.
//

import SwiftUI
import SwiftData

@main
struct Tourpedo_AppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AppRoot()
                .preferredColorScheme(.light)
                .environmentObject(ViewModel())
        }
        .modelContainer(sharedModelContainer)
        
        
        
    }
}
