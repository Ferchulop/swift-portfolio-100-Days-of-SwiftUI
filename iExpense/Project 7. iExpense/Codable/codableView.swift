//
//  codableView.swift
//  Project 7. iExpense
//
//  Created by Fernando Jurado on 18/9/24.
//

import SwiftUI
// Añado protocolo Codable para archivar y desarchivar a otros formatos de  datos, en este ejemplo alamcenaremos un valor por defecto como es el nombre y apellido para convertirlo en formato JSON
struct User1: Codable {
    let firstName: String
    let lastName: String
    
}

struct codableView: View {
    @State private var user = User1(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
            
        }
    }
}

#Preview {
    codableView()
}
