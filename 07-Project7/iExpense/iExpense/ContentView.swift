//
//  ContentView.swift
//  iExpense
//
//  Created by sardar saqib on 27/12/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var personalExpenses : [ExpenseItem] {
        return expenses.items.filter({$0.type == "Personal"})
    }
    var businessExpenses : [ExpenseItem] {
        return  expenses.items.filter({$0.type == "Business"})
    }
    var body: some View {
        NavigationStack {
            List {
                
                Section(personalExpenses.count == 0 ? "" : "Personal Expenses") {
                    ForEach(personalExpenses, id: \.id) { personalItem in
                        listRow(rowItem: personalItem)
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(at: indexSet, from: personalExpenses)
                    })
                }
                
                Section(businessExpenses.count == 0 ? "" : "Business Expenses") {
                    ForEach(businessExpenses, id: \.id) { businessItem in
                        listRow(rowItem: businessItem)
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(at: indexSet, from: businessExpenses)
                    })
                    
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    private func removeItems(at offsets: IndexSet, from filteredItems: [ExpenseItem]) {
            for index in offsets {
                if let originalIndex = expenses.items.firstIndex(where: { $0.id == filteredItems[index].id }) {
                    expenses.items.remove(at: originalIndex)
                }
            }
        }
    
    @ViewBuilder
    func listRow(rowItem:ExpenseItem) -> some View {
        HStack {
               VStack(alignment: .leading) {
                   Text(rowItem.name)
                       .font(.headline)
                   Text(rowItem.type)
               }

               Spacer()
            
            Text(rowItem.amount, format: .currency(code: rowItem.currancy))
           }
    }
}

#Preview {
    ContentView()
}


struct ExpenseItem : Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currancy: String
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}
