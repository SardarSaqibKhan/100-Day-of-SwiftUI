//
//  UserModel.swift
//  Milestone: Projects 10-12
//
//  Created by sardar saqib on 02/01/2025.
//

import Foundation
import SwiftData

@Model
class UserModel: Codable, Hashable{
    
    var id:String = ""
    var isActive: Bool
    var name:String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about:String
    var registered:String
    var tags: [String]
    @Relationship(deleteRule: .cascade) var friends: [Friends]
    
    var displayDate: String {
        let isoDateFormatter = ISO8601DateFormatter()
        let dateFormatter = DateFormatter()
        guard let date = isoDateFormatter.date(from: registered) else {
            return registered
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let StrDate = dateFormatter.string(from: date)
        return StrDate
    }
    
    enum CodingKeys : String, CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(String.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friends].self, forKey: .friends)
        
        
    }
    func encode(to encoder: any Encoder) throws {
        
    }
    
    @Model
    class Friends : Codable, Hashable {
        var id: String
        var name: String
        
        enum CodingKeys : String, CodingKey {
            case id
            case name
        }
        
        required init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
        }
        func encode(to encoder: any Encoder) throws {
            
        }
    }
}
