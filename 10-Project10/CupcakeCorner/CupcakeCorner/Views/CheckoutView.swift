//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by sardar saqib on 31/12/2024.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var order : Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is : \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank Your!", isPresented: $showingConfirmation) {
            Button("Ok", action: {})

        } message: {
            Text(confirmationMessage)
        }
    
    }
    
    func placeOrder() async {
        guard let encodedData = try? JSONEncoder().encode(order) else {
            fatalError("unable to encode data")
        }
        
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            fatalError("unable to create URl.")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: urlRequest, from: encodedData)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            
        } catch EncodingError.invalidValue(_ , let context) {
            //fatalError("inavlid values \(context.debugDescription)")
            confirmationMessage = "Encoding Error : invalid values \(context.debugDescription)"
            showingConfirmation = true
        }
        catch {
           // fatalError("unable to upload data due to \(error.localizedDescription)")
            confirmationMessage = "Unable to upload data due to : \(error.localizedDescription)"
            showingConfirmation = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
