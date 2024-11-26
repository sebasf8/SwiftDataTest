//
//  ContentView.swift
//  swiftDataTest
//
//  Created by Sebastian Fernandez on 26/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var viewModel =  ContentViewModel(service: ItemActor(modelContainer: PersistenceStack.shared.modelContainer))

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.expenses) { item in
                    let formattedExpense = item.amount.formatted(.currency(code: "EUR"))
                    NavigationLink {
                        Text("\(formattedExpense) at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        VStack (alignment: .leading){
                            Text("\(formattedExpense)")
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .animation(.default, value: viewModel.expenses)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .task {
            await viewModel.load()
        }
    }

    private func addItem() {
        Task { await viewModel.addExpense() }
    }

    private func deleteItems(offsets: IndexSet) {
        Task { await viewModel.delete(offsets: offsets) }
    }
}

#Preview {
    ContentView()
}
