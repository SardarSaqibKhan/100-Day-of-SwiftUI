//
//  Missions.swift
//  Moonshot
//
//  Created by sardar saqib on 30/12/2024.
//

import Foundation

struct Missions : Codable, Identifiable {
    let id : Int
    let crew : [Crew]
    let launchDate : Date?
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    var imageName : String {
        "apollo\(id)"
    }
    var formattedDate : String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    struct Crew : Codable {
        let name: String
        let role: String
    }
}



struct CrewMember {

    let role: String
    let astronaut: Astronauts
}
