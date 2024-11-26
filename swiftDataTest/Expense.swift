//
//  Item.swift
//  swiftDataTest
//
//  Created by Sebastian Fernandez on 26/11/24.
//

import Foundation
import SwiftData

@Model
final class Expense {
    var timestamp: Date
    var amount: Double

    init(timestamp: Date, amount: Double) {
        self.timestamp = timestamp
        self.amount = amount
    }
}
