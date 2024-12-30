//
//  AstronautView.swift
//  Moonshot
//
//  Created by sardar saqib on 30/12/2024.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronauts
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AstronautView(astronaut: .init(id: "", name: "", description: ""))
}
