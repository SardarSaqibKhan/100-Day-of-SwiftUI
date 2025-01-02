//
//  UserView.swift
//  Milestone: Projects 10-12
//
//  Created by sardar saqib on 02/01/2025.
//

import SwiftUI
import SwiftData


struct UserView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users : [UserModel]
    @StateObject var viewModel = UserViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(value: user) {
                        UserListRow(user: user)
                    }
                }
            }
            .onAppear(perform: {
                if users.isEmpty {
                    viewModel.getUsers(modelContext: modelContext)
                }
            })
            .navigationTitle("Users")
            .navigationDestination(for: UserModel.self) { user in
                UserDetailView(user: user)
            }
        }
    }
}
struct UserListRow : View {
    let user: UserModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(user.name)
                .font(.title.bold())
            HStack {
                Text("Status:")
                    .font(.headline.bold())
                Text(user.isActive ? "Active" : "Inactive")
                Circle()
                    .fill(Color(user.isActive ? UIColor.green : UIColor.red))
                    .frame(width: 15)
                    
            }
        }
    }
}
#Preview {
    UserView()
}
