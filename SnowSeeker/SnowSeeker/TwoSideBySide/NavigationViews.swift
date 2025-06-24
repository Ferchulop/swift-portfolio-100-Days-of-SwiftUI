//
//  NavigationViews.swift
//  SnowSeeker
//
//  Created by Fernando Jurado on 20/6/25.
//

import SwiftUI

struct NavigationViews: View {
    var body: some View {
        // Vista para presentar vistas en dos o tres columnas
        /*NavigationSplitView {
            Text("List")
        } detail: {
            Text("Detail")
        }*/
        // Otra opción para navegar entre vistas
        /*NavigationSplitView {
            NavigationLink("Primary") {
                Text("List")
            }
            } detail: {
                Text("Content")
            }*/
        // siempre se mostrarán todas las columnas disponibles ó
        // puedes elegir preferredCompactColumn: .constant(.detail)
        /*NavigationSplitView(columnVisibility: .constant(.all)) {
            NavigationLink("Primary") {
                Text("New view")
            }
            
        } detail: {
            Text("Content")
        }
        // Para repartir el espacio de forma equitativa, balanceada
        .navigationSplitViewStyle(.balanced)*/
        // En vertical, con .toolbar puedes hacer que no sea visible la opcion de vistas en columnas
        NavigationSplitView {
            NavigationLink("Primary") {
                Text("New view")
            }
            
        } detail: {
            Text("Content")
                .toolbar(.hidden, for: .navigationBar)
        }
    }
        
}

#Preview {
    NavigationViews()
}
