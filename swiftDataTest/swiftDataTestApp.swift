//
//  swiftDataTestApp.swift
//  swiftDataTest
//
//  Created by Sebastian Fernandez on 26/11/24.
//

import SwiftUI
import SwiftData

@main
struct swiftDataTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(PersistenceStack.shared.modelContainer)
    }
}
