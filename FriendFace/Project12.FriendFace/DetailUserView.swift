//
//  DetailUserView.swift
//  Project12.FriendFace
//
//  Created by Fernando Jurado on 30/11/24.
//

import SwiftUI

struct DetailUserView: View {
    let user: User
    var body: some View {
        NavigationStack {
            Text(initials(from: user.name) ?? "")
                .font(.largeTitle)
                .padding(50)
            
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(user.isActive ? .green : .red, lineWidth: 3 )
                }
                .padding(10)
            // Dentro de una lista añado cada una de sus secciones para mostrar su info general
            List {
                
                
                Section("General Info") {
                    Text("Age: \(user.age)")
                    Text("Company: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                    Text("Registered: \(user.formattedDate)")
                    
                }
                
                Section("About") {
                    Text("\(user.about)")
                    
                }
                
                Section("Tags") {
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(user.tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(5)
                                    .background(.blue)
                                    .foregroundStyle(.white)
                                    .clipShape(.capsule)
                                
                            }
                        }
                        
                    }
                    
                }
                
                Section("Friends") {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                    
                }
                
                
            }
            
            .navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func initials(from fullName: String) -> String? {
        let formatter = PersonNameComponentsFormatter()
        if let initials = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: initials)
        }
        return nil
        
    }
}

#Preview {
    // Instancia de mi propiedad estatica preconfigurada en la clase user para mostrar la previsualizacion
    DetailUserView(user: .example)
}
