//
//  AddBookView.swift
//  Bookworm
//
//  Created by sardar saqib on 01/01/2025.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var bookTitle = ""
    @State var author = ""
    @State var genre = "Fantasy"
    @State var review = ""
    @State var rating = 0
    var bookGenres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var isDisabled : Bool {
        if bookTitle.isEmpty || author.isEmpty || genre.isEmpty {
            return true
        }
        return false
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name of book", text: $bookTitle)
                TextField("Author's name", text: $author)
                Picker("Genre", selection: $genre) {
                    ForEach(bookGenres, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Section("Write a Review") {
                TextEditor(text: $review)
                RatingView(rating: $rating)
            }
            
            Section {
                Button("Add Book") {
                    addNewBook()
                }
            }
            .disabled(isDisabled)
        }
        .navigationTitle("Save Book")
    }
    
    func addNewBook(){
        let newBook = Book(title: bookTitle, author: author, genre: genre, review: review, rating: rating, date: Date.now)
        modelContext.insert(newBook)
        dismiss()
    }
}

#Preview {
    AddBookView()
}

struct RatingView : View {
    @Binding var rating:Int
    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}
