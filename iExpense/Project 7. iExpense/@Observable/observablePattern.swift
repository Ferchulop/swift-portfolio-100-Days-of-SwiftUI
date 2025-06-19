//
//  observablePattern.swift
//  Project 7. iExpense
//
//  Created by Fernando Jurado on 16/9/24.
//
import SwiftUI
// Utilizo el patron @Observable para que pueda observar estos cambios en los datos y los actualice en la interfaz, en este caso lo introducido en el TextField
@Observable
// Utilizo class para poder compartir y modificar el estado de la propiedad en multiples partes del código
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}


struct observablePattern: View {
    @State private var user = User()
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            
        }
    }
}

#Preview {
    observablePattern()
}
