//
//  Book.swift
//  Bookworm
//
//  Created by sardar saqib on 01/01/2025.
//

import Foundation
import SwiftData

@Model
class Book {
    
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date:Date
    var displayDate: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}
