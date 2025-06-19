//
//  DetailView.swift
//  Project11.Bookworm
//
//  Created by Fernando Jurado on 21/11/24.
//
import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
                
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.review)
                .padding()
           
            RatingView(rating: .constant (book.rating))
                .font(.largeTitle)
            
            Text("Added on: \(book.date.formatted(date: .numeric,time: .shortened))")// CHALLENGE 3
                                       .font(.subheadline)
                                       .foregroundStyle(.secondary)
                                       .frame(maxWidth: .infinity, alignment: .trailing)
                                       .padding()

            
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
            
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}





#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Example", author: "Example Author", genre: "Fantasy", review: "Example Review", rating: 5, date: Date.now)
        return  DetailView(book: example)
            .modelContainer(container)
    } catch {
        
        return Text("Failed to create preview: \(error.localizedDescription).")
    }
    
}
