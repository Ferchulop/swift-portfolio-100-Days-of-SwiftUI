//
//  LayoutContainers.swift
//  SnowSeeker
//
//  Created by Fernando Jurado on 20/6/25.
//

import SwiftUI

struct UserView: View {
    var body: some View {
    Group {
        Text("Name: Paul")
        Text("Country: Spain")
        Text("Pets: Luna and Arya")
        
    }
    .font(.title)
}
}

struct LayoutContainers: View {
    // 1º Forma de presentar las vistas en vertical y horizontal.
    /*@State private var layoutVertically = false
    var body: some View {
        Button {
            layoutVertically.toggle()
            
        } label: {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                
                HStack {
                    UserView()
                }
            }
            
        }*/
    // 2º forma de presentar las vistas en vertical y horizontal con @Environment.  A diferencia del ejemplo anterior, aquí el usuario no tiene que tocar nada. El layout cambia automáticamente dependiendo del tamaño de pantalla.
   /* @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack(content: UserView.init)
                //UserView()
            
        } else {
            HStack(content: UserView.init)
                // Tambien funcionaria inicializando userview.init
                //UserView()
            
        }*/
    // 3º forma: evalúa una lista de vistas en orden y renderiza solo la primera que quepa en el espacio disponible. Una especie de if let visual que simplifica el diseño adaptable.
    var body: some View {
        ViewThatFits {
            Rectangle()
                .frame(width: 500, height: 200)
            
            Circle()
                .frame(width: 200, height: 200)
    }
    
    }
}

#Preview {
    LayoutContainers()
}
