//
//  Order.swift
//  CupcakeCorner
//
//  Created by sardar saqib on 31/12/2024.
//

import Foundation

@Observable
class Order : Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var address = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress : Bool {
        if name.isEmpty || address.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        if name.contains(" ") || address.contains(" ") || city.contains(" ") || zip.contains(" ") {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
    
    enum CodingKeys : String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _address = "address"
        case _zip = "zip"
    }
}
