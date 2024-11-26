//
//  ItemActor.swift
//  swiftDataTest
//
//  Created by Sebastian Fernandez on 26/11/24.
//

import Foundation
import SwiftData

@ModelActor
actor ItemActor: ItemRepository {
    func fetchItems() async throws -> [ExpenseDTO] {
        try modelContext.fetch(FetchDescriptor<Expense>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])).map { ExpenseDTO(model: $0) }
    }

    func insert(expense: ExpenseDTO) async throws {
        let model = fetchExpense(id: expense.id) ?? Expense(timestamp: expense.timestamp, amount: expense.amount)
        modelContext.insert(model)
        try modelContext.save()
    }

    func delete(expense: ExpenseDTO) async throws {
        guard let model = fetchExpense(id: expense.id) else { return }

        modelContext.delete(model)
        try modelContext.save()
    }

    private func fetchExpense(id: PersistentIdentifier?) -> Expense? {
        guard let id else { return nil }

        return modelContext.model(for: id) as? Expense
    }
}
