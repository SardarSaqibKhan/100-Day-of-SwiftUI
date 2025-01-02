//
//  UserDetailView.swift
//  Milestone: Projects 10-12
//
//  Created by sardar saqib on 02/01/2025.
//

import SwiftUI

struct UserDetailView: View {
    let user : UserModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Name: ")
                        .font(.headline.bold())
                    Text(user.name)
                }
                HStack {
                    Text("Status: ")
                        .font(.headline.bold())
                    Text(user.isActive ? "Active" : "Inactive")
                    Circle()
                        .fill(Color(user.isActive ? UIColor.green : UIColor.red))
                        .frame(width: 15)
                }
                HStack {
                    Text("Age: ")
                        .font(.headline.bold())
                    Text(String(user.age))
                }
                HStack {
                    Text("Company: ")
                        .font(.headline.bold())
                    Text(user.company)
                }
                HStack {
                    Text("Email: ")
                        .font(.headline.bold())
                    Text(user.email)
                }
                HStack {
                    Text("Address: ")
                        .font(.headline.bold())
                    Text(user.address)
                }
                HStack(alignment: .top) {
                    Text("About: ")
                        .font(.headline.bold())
                    Text(user.about)
                }
                HStack {
                    Text("Registerd Date: ")
                        .font(.headline.bold())
                    Text(user.displayDate)
                }
                HStack(alignment: .top) {
                    Text("Tags: ")
                        .font(.headline.bold())
                    Text(user.tags.joined(separator: ", "))
                }
                HStack(alignment: .top) {
                    Text("Friends: ")
                        .font(.headline.bold())
                    Text(user.friends.map({$0.name}).joined(separator: ", "))
                }
               
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("\(user.name) Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

