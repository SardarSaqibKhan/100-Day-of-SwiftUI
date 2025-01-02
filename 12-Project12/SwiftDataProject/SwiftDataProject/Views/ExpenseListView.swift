//
//  ExpenseListView.swift
//  SwiftDataProject
//
//  Created by sardar saqib on 01/01/2025.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortByName = true
   
    @State var expenseFilterType: ExpenseType = .all
    
   
    
    
    var body: some View {
        NavigationStack {
            FilterExpensesView(expenseType: expenseFilterType.rawValue, sortByName: sortByName)
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(sortByName ? "Sort by Name" : "Sort by Amount") {
                        sortByName.toggle()
                    }
                }
               
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        AddExpenseView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Filter", selection: $expenseFilterType) {
                            ForEach(ExpenseType.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
struct ExpenseRow : View {
    let expense : Expenses
    var body: some View {
        HStack {
        VStack(alignment: .leading) {
                Text(expense.name)
                Text(expense.type)
            }
            
            Spacer()
            
            Text(expense.amount, format: .currency(code: expense.currancy))
        }
    }
}

#Preview {
    ExpenseListView()
}
