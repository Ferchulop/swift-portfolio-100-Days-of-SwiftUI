//
//  ContentView.swift
//  Project12.FriendFace
//
//  Created by Fernando Jurado on 30/11/24.
//
import SwiftData
import SwiftUI


struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    // Consulta que me permite obtener y ordenar de forma ascendente una lista de objetos de tipo User
    @Query(sort: \User.name) private var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink {
                    DetailUserView(user: user)
                } label: {
                    HStack {
                        Text(initials(from: user.name) ?? "" )
                            .font(.title)
                            .padding()
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(user.isActive ? .green : .red, lineWidth: 3 )
                            }
                        
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .fontWeight(.bold)
                            Text(user.isActive ? "Active" : "Inactive")
                                .foregroundStyle(user.isActive ? .green : .red)
                            
                            
                        }
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("FriendF☻ce")
                        .font(.largeTitle.bold())
                }
            }
            // Ejecuto la tarea asincrona al cargar la vista, llamando a la funcion de fetchusers
            .task {
                await fetchUsers() // cargo los usuarios
                
            }
        }
        
        
    }
    // Función para mostrar las iniciales de los nombres, utilizando la clase: PersonNameComponentsFormatter
    func initials(from fullName: String) -> String? {
        let formatter = PersonNameComponentsFormatter()
        if let initials = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: initials)
        }
        return nil
        
    }
    // Función para filtrar los usuarios
    func fetchUsers() async {
        guard users.isEmpty else { return }
        
        do {
            let url = URL(string:"https://www.hackingwithswift.com/samples/friendface.json")!
            let(data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedUser = try decoder.decode([User].self, from: data)
            // Itero sobre los usuarios decodificados e inserto cada usuario en el modelContext
            for user in decodedUser {
                modelContext.insert(user)
            }
            
            
        } catch {
            print("Error managing data: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
