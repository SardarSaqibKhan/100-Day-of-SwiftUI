//
//  FilterExpensesView.swift
//  SwiftDataProject
//
//  Created by sardar saqib on 01/01/2025.
//

import SwiftUI
import SwiftData

struct FilterExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Expenses.name) var expenses : [Expenses]
    var filterExpenseType:ExpenseType = .all
    
    
    init(expenseType:String, sortByName:Bool) {
        filterExpenseType = ExpenseType(rawValue: expenseType) ?? .all
           
        guard expenseType != "All" else {
            _expenses = sortByName ? Query(filter: nil, sort: \Expenses.name) : Query(filter: nil, sort: \Expenses.amount)
            return
        }
        if sortByName {
            _expenses = Query(filter: #Predicate<Expenses> { expenseObj in
                expenseObj.type == expenseType
            }, sort: \Expenses.name)
        } else {
            _expenses = Query(filter: #Predicate<Expenses> { expenseObj in
                expenseObj.type == expenseType
            }, sort: \Expenses.amount)
        }
      
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(filterExpenseType.rawValue) {
                    ForEach(expenses, id: \.id) { expense in
                        ExpenseRow(expense: expense)
                    }
                    .onDelete(perform: deleteExpense(at:))
                }
            }
            .navigationTitle("iExpense")
        }
    }
    
    func deleteExpense(at indexSets: IndexSet) {
        for indexset in indexSets {
            let filteredExp = expenses[indexset]
            modelContext.delete(filteredExp)
        }
    }
}

#Preview {
    FilterExpensesView(expenseType: "",sortByName: true)
}
