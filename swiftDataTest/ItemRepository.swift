//
//  ItemRepository.swift
//  swiftDataTest
//
//  Created by Sebastian Fernandez on 26/11/24.
//

import Foundation
import SwiftData

protocol ItemRepository: Sendable {
    func fetchItems() async throws -> [ExpenseDTO]

    func insert(expense: ExpenseDTO) async throws

    func delete(expense: ExpenseDTO) async throws
}
