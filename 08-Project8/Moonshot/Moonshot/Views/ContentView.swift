//
//  ContentView.swift
//  Moonshot
//
//  Created by sardar saqib on 30/12/2024.
//

import SwiftUI

struct ContentView: View {
    let missions : [Missions] = Bundle.main.decode(file: "missions.json")
    
    let column = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: column) {
                    ForEach(missions) { mission in
                        
                        NavigationLink {
                            MissionView(mission: mission)
                        } label: {
                            VStack {
                                Image(mission.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(minWidth: 100, maxWidth: .infinity)
                                .background(.lightBackground)
                                .clipShape(.rect(cornerRadius: 10))
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            }
                        }
                    }

                }
                .padding([.horizontal, .bottom])
                
            }
            .navigationTitle("MoonShots")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
