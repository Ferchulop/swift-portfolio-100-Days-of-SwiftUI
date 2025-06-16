//
//  ContentView.swift
//  Project11.Bookworm
//
//  Created by Fernando Jurado on 19/11/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Book.title), SortDescriptor(\Book.author)]) var books: [Book] // Consulta que obtiene y ordena los libros almacenados por título y autor
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating) // Muestra el emoji según la calificación
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating == 1 ? .red : .primary) // CHALLENGE 2
                                   
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                                
        
                            }
                        }
                        
                    }
                }
                .onDelete(perform: deleteBooks) // Con onDelete y el metodo borrar libros de la lista
            }
            
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book) // Navega y muestra la vista DetailView donde mostrará los detalles del libro
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
                
                
            }
        }
    }
    // Elimina libros seleccionados de la lista
        func deleteBooks(at offsets: IndexSet) {
            for offset in offsets {
              let book = books[offset]
                modelContext.delete(book)
            
            
        }
    }
}

#Preview {
    
    return ContentView()
        .modelContainer(for: Book.self)
}
