//
//  AllBooks.swift
//  Bookworm
//
//  Created by sardar saqib on 01/01/2025.
//

import SwiftUI
import SwiftData

struct AllBooks: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.rating, order: .reverse),
        SortDescriptor(\Book.title, order: .forward),
        SortDescriptor(\Book.author, order: .forward)
    ]) var books: [Book]
    @State var showAddBook = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books, id: \.self) { book in
                   
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBook(at:))
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add book", systemImage: "plus") {
                        showAddBook = true
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddBook) {
                AddBookView()
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
        }
        
    }
    
    func deleteBook(at indexOffset : IndexSet){
        for indexset in indexOffset {
            let foundBook = books[indexset]
            modelContext.delete(foundBook)
        }
    }
}

#Preview {
    AllBooks()
}
