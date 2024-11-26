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
        let model = fetchUpdatedExpense(dto: expense)

        modelContext.insert(model)
        try modelContext.save()
    }

    func delete(expense: ExpenseDTO) async throws {
        guard let model = fetchExpense(id: expense.id) else { return }

        modelContext.delete(model)
        try modelContext.save()
    }
    
    private func fetchUpdatedExpense(dto: ExpenseDTO) -> Expense {
        guard let model = fetchExpense(id: dto.id) else {
            return Expense(timestamp: dto.timestamp, amount: dto.amount)
        }

        model.amount = dto.amount
        model.timestamp = dto.timestamp

        return model
    }

    private func fetchExpense(id: PersistentIdentifier?) -> Expense? {
        guard let id else { return nil }

        return modelContext.model(for: id) as? Expense
    }
}
