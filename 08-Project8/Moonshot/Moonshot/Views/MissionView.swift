//
//  MissionView.swift
//  Moonshot
//
//  Created by sardar saqib on 30/12/2024.
//

import SwiftUI

struct MissionView: View {
    let mission : Missions
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometryReader in
            ScrollView (.vertical) {
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometryReader.size.width * 0.7)
                        .padding(.top)
                    
                    VStack(alignment: .leading){
                        Text("Misson Hightlights:")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(.capsule)
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(.white, lineWidth: 1)
                                            )
                                        
                                        VStack(alignment: .leading) {
                                            Text(crewMember.astronaut.name)
                                                .foregroundStyle(.white)
                                                .font(.headline)
                                            Text(crewMember.role)
                                                .foregroundStyle(.white.opacity(0.5))
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
       
    }
    
    init(mission: Missions) {
        self.mission = mission
        let astronautsData : [Astronauts] = Bundle.main.decode(file: "astronauts.json")
        self.crew = mission.crew.map({ crew in
            if let asto = astronautsData.first(where: {$0.id == crew.name}) {
                return CrewMember(role: crew.role, astronaut: asto)
            } else {
                fatalError("Missing \(crew.name)")
            }
            
        })
    }
}

/*#Preview {
    let missions: [Missions] = Bundle.main.decode(file: "missions.json")
    return MissionView(mission: missions[0])
        .preferredColorScheme(.dark)
}*/
