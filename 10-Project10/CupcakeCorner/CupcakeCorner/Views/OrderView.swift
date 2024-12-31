//
//  OrderView.swift
//  CupcakeCorner
//
//  Created by sardar saqib on 31/12/2024.
//

import SwiftUI

struct OrderView: View {
    @State private var order = Order()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) { 
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...12)
                }
                
                Section {
                    Toggle("Any special request ?", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                        
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details", destination: AddressView(order: order))
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    OrderView()
}
