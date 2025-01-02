//
//  AddExpenseView.swift
//  SwiftDataProject
//
//  Created by sardar saqib on 01/01/2025.
//

import SwiftUI
import SwiftData

enum ExpenseType : String, CaseIterable {
    case all = "All"
    case personal = "Personal"
    case business = "Business"
    
    var displayName : String {
        switch self {
        case .personal:
            "Personal Expenses"
        case .business:
            "Business Expenses"
        case .all:
            "All Expenses"
        }
    }
}
enum Currency : String, CaseIterable {
    case usd = "USD"
    case pound = "GBP"
    case rupees = "PKR"
    case euro = "EUR"
}

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var name = ""
    @State var type = ExpenseType.personal
    @State var currancy = Currency.usd
    @State var amount = 0.0
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Expense Name", text: $name)
                    
                    Picker("Expense Type", selection: $type) {
                        ForEach(ExpenseType.allCases, id: \.self) { expense in
                            Text(expense.rawValue)
                        }
                    }
                    
                    HStack {
                        TextField("Amount", value: $amount, format: .currency(code: currancy.rawValue))
                            .keyboardType(.decimalPad)
                        
                        Picker("", selection: $currancy) {
                            ForEach(Currency.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let expense = Expenses(name: name, type: type.rawValue, amount: amount, currancy: currancy.rawValue)
                    modelContext.insert(expense)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddExpenseView()
}
