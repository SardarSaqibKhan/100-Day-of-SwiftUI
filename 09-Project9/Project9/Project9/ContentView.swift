//
//  ContentView.swift
//  Project9
//
//  Created by sardar saqib on 30/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ForEach(0..<100){ item in
                NavigationLink("Select \(item)", value: item)
            }
        }
    }
}

#Preview {
    ContentView()
}
