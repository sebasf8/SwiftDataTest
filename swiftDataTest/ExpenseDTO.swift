//
//  ExpenseDTO.swift
//  swiftDataTest
//
//  Created by Sebastian Fernandez on 26/11/24.
//

import Foundation
import SwiftData

struct ExpenseDTO: Identifiable, Equatable {
    let id: PersistentIdentifier?
    var timestamp: Date
    var amount: Double

    init(id: PersistentIdentifier?, timestamp: Date, amount: Double) {
        self.id = id
        self.timestamp = timestamp
        self.amount = amount
    }

    init(model: Expense) {
        id = model.id
        timestamp = model.timestamp
        amount = model.amount
    }
}
