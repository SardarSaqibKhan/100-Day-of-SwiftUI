//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by sardar saqib on 31/12/2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order : Order
    var body: some View {
        Form {
            Section {
                TextField("Enter Name", text: $order.name)
                TextField("Enter Address", text: $order.address)
                TextField("Enter City", text: $order.city)
                TextField("Enter Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check Out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false )
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
