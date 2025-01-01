//
//  BookwormApp.swift
//  Bookworm
//
//  Created by sardar saqib on 01/01/2025.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            AllBooks()
        }
        .modelContainer(for: Book.self)
    }
}
