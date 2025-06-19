//
//  FuncionalityBinding.swift
//  Project11.Bookworm
//
//  Created by Fernando Jurado on 19/11/24.
//

import SwiftUI
struct PushButton: View {
    let title: String
    // Es como un "enlace" que conecta una propiedad local con una propiedad de otra vista. Refleja los datos y los actualiza en su fuente original, en este caso en la struct funcionalityBinding.
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.8), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(.linearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
    
}


struct FuncionalityBinding: View {
    @State private var rememberMe = false
    var body: some View {
        PushButton(title: "Remember Me", isOn: $rememberMe)
        Text(rememberMe ? "On" : "Off")
            
        }
    }

#Preview {
    FuncionalityBinding()
}
