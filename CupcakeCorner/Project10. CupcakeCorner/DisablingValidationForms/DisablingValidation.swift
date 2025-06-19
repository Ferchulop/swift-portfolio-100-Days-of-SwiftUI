//
//  DisablingValidation.swift
//  Project10. CupcakeCorner
//
//  Created by Fernando Jurado on 7/11/24.
//

import SwiftUI

// Con .disabled podemos habilitar o deshabilitar cualquier cosa que queramos en el formulario, para eso probamos con dos ejemplos, el segundo creando una variable con un booleano:
struct DisablingValidation: View {
    @State private var username = ""
    @State private var email = ""
    
    var disabledForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            // 1º ej: .disabled(username.isEmpty || email.isEmpty)
            .disabled(disabledForm)
        }
    }
}

#Preview {
    DisablingValidation()
}

