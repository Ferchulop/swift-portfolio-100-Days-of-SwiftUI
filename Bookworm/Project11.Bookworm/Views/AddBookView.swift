//
//  AddBookView.swift
//  Project11.Bookworm
//
//  Created by Fernando Jurado on 20/11/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext // Property wrapper para gestionar las operaciones CRUD
    @Environment(\.dismiss) var dismiss //Property wrapper para cerrar la vista actual
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var rating = 3
    @State private var review = ""
    
    let genres = ["Fantasy", "Poetry", "Horror", "Romance", "Mystery", "Thriller","Kids"]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author´s name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                            
                        }
                    }
                    
                }
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date.now)
                        modelContext.insert(newBook)
                        dismiss()
                            
                    }
                    // CHALLENGE 1
                    // Me aseguro de que los campos autor y titulo esten rellenados antes de guardar 
                    .disabled(title.isEmpty || author.isEmpty)
                    
                    
                }
                
                
            }
            
            .navigationTitle("Add Book")
            
        }
        
        
        
    }
}

#Preview {
    AddBookView()
}
