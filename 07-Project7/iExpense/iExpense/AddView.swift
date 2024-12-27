//
//  AddView.swift
//  iExpense
//
//  Created by sardar saqib on 27/12/2024.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    let avaiableCurrencies = ["USD", "PKR", "GBP", "EUR", "CNY", "SAR"]
    @State private var selectedCurrancy = "USD"
    var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                HStack {
                    
                    TextField("Amount", value: $amount, format: .currency(code: selectedCurrancy))
                        .keyboardType(.decimalPad)
                    Picker("", selection: $selectedCurrancy) {
                        ForEach(avaiableCurrencies, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: selectedCurrancy) { oldValue, newValue in
                        print("old \(oldValue)")
                        print("new \(newValue)")
                        print("amount \(amount)")
                    }
                }
                
               
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currancy: selectedCurrancy)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
