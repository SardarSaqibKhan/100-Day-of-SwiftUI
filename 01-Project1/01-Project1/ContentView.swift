//
//  ContentView.swift
//  01-Project1
//
//  Created by sardar saqib on 03/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    
    var grandTotal: Double {
            let tipSelection = Double(tipPercentages[tipPercentage])
            let orderAmount = Double(checkAmount) ?? 0
            let tipValue = orderAmount / 100 * tipSelection
            let grandTotal = orderAmount + tipValue
            return grandTotal
        }
        
        var totalPerPerson: Double {
            let peopleCount = Double(numberOfPeople) ?? 1
            let amountPerPerson = grandTotal / peopleCount
            return amountPerPerson
        }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .textCase(nil)
                
                Section {
                    Text("\(grandTotal, specifier: "%.2f")")
                } header: {
                    Text("Total Amounnt:")
                }
                .textCase(nil)
                
                Section {
                    Text("\(totalPerPerson, specifier: "%.2f")")
                } header: {
                    Text("Amounnt Per Person:")
                }
                .textCase(nil)
            }
            .navigationTitle("Wesplit SwiftUI Project-1")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
