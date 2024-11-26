//
//  ItemActor.swift
//  swiftDataTest
//
//  Created by Sebastian Fernandez on 26/11/24.
//

import Foundation
import SwiftData

@ModelActor
actor ItemActor {
    func fetchItems() throws -> [Expense] {
        try modelContext.fetch(FetchDescriptor<Expense>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)]))
    }

    func insert(expense: Expense) throws {
        modelContext.insert(expense)
        try modelContext.save()
    }

    func delete(expense: Expense) throws {
        modelContext.delete(expense)
        try modelContext.save()
    }
}
