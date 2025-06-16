//
//  showHideViews.swift
//  Project 7. iExpense
//
//  Created by Fernando Jurado on 16/9/24.
//

import SwiftUI

struct secondView: View {
    //Utilizo property wrapper environment para acceder a valores compartidos en las demas vistas.Sin necesidad de pasar manualmente esos valores a cada vista hija.Utilizo dismiss para cerrar o descartar en este caso la vista principal y paso su metodo en el contenido del boton
    @Environment (\.dismiss) var dismiss
    let name: String
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct showHideViews: View {
    @State private var showingSheet = false
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        // Utilizo modificador de vista para presentar la vista secundaria sobre la actual en la que se encuentra el boton "Show Sheet"
        .sheet(isPresented: $showingSheet) {
            secondView(name: "@twostraws")
        }
    }
}

#Preview {
    showHideViews()
}
