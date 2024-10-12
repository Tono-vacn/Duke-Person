//
//  YuchenApp.swift
//  Yuchen
//
//  Created by Fall2024 on 9/26/24.
//

import SwiftUI
import SwiftData

@main
struct YuchenApp: App {
    
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            DukePerson.self,
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(DataManager(modelContext: sharedModelContainer.mainContext))
    }
}
