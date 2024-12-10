//
//  ContentView.swift
//  03-Project3
//
//  Created by sardar saqib on 10/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                NavigationLink {
                    ProjectOneView()
                } label: {
                    Text("Open Project 1")
                }
                NavigationLink {
                    ProjectTwoView()
                } label: {
                    Text("Open Project 2")
                }

            }
            .font(.title)
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
