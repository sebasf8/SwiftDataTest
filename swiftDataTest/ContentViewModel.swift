//
//  ContentViewModel.swift
//  swiftDataTest
//
//  Created by Sebastian Fernandez on 26/11/24.
//

import Foundation
import SwiftData

@MainActor @Observable
class ContentViewModel {
    private(set) var expenses: [Expense] = []

    let service: ItemActor

    init(service: ItemActor) {
        self.service = service
    }

    func load() async {
        expenses = (try? await fetchData()) ?? []
    }

    nonisolated func fetchData() async throws -> [Expense] {
        return try await service.fetchItems()
    }

    func addExpense() async {
        let newItem = Expense(timestamp: Date(), amount: Double.random(in: 0...1000))
        try? await service.insert(expense: newItem)

        await load()
    }

    func delete(offsets: IndexSet) async {
        for index in offsets {
            try? await service.delete(expense: expenses[index])
        }

        await load()
    }
}
