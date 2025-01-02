//
//  Milestone__Projects_10_12App.swift
//  Milestone: Projects 10-12
//
//  Created by sardar saqib on 02/01/2025.
//

import SwiftUI
import SwiftData

@main
struct Milestone__Projects_10_12App: App {
    var body: some Scene {
        WindowGroup {
            UserView()
        }
        .modelContainer(for: UserModel.self)
    }
}
