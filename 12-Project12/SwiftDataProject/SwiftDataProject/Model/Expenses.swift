//
//  Expenses.swift
//  SwiftDataProject
//
//  Created by sardar saqib on 01/01/2025.
//

import Foundation
import SwiftData

@Model
class Expenses {
    
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    var currancy: String
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double, currancy: String) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.currancy = currancy
    }
}
