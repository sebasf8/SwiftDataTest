//
//  PersistenceStack.swift
//  swiftDataTest
//
//  Created by Sebastian Fernandez on 26/11/24.
//

import Foundation
import SwiftData

class PersistenceStack {
    static let shared: PersistenceStack = PersistenceStack()
    let modelContainer: ModelContainer

    private init() {
        do {
            let schema = Schema([
                Expense.self,
            ])

            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
    }
}
