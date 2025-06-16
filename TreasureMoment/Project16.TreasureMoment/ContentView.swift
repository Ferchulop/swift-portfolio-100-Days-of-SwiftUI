//
//  ContentView.swift
//  Project16.TreasureMoment
//
//  Created by Fernando Jurado on 24/1/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query(sort:\User.name) private var users:[User]
    @State private var showAddUserView = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.id) { items in
                    NavigationLink(destination:  {
                        DetailPhotoView(user: items)
                        
                    }, label: {
                        
                        HStack {
                            if let photo = items.imageData, let uiImage = UIImage(data: photo) {
                                Image(uiImage:uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 100, height: 100)
                                    .shadow(radius: 5)
                            }
                            Text(items.name)
                                .font(.headline)
                                .bold()
                        }
                        
                    })
                    
                }
                .onDelete(perform: { i in
                    for index in i {
                        deleteItems(users[index])
                    }
                    
                })
            }
            .navigationTitle("Treasure Moment")
            .toolbar {
                Button(action:  {
                    showAddUserView.toggle()
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $showAddUserView,  content: {
                AddPhotoView()
                    .presentationDetents([.medium])
            })
        }
        
    }
    // Eliminar vistas de detalle de la lista 
    func deleteItems(_ item: User) {
        context.delete(item)
        
    }
}


#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
