//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by sardar saqib on 01/01/2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ExpenseListView()
        }
        .modelContainer(for: Expenses.self)
    }
}
