//
//  onDeleteView.swift
//  Project 7. iExpense
//
//  Created by Fernando Jurado on 18/9/24.
//

import SwiftUI

struct onDeleteView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    var body: some View {
        // Añado NavigationStack para visualizar las filas eliminados de distinta forma:
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers,id: \.self) {
                        Text("Row \($0)")
                    }
                    // Añado modificador onDelete para la eliminacion de las filas
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            // Añado toolbar para visualizar en esquina derecha el editar y poder eliminar la fila con otra apariencia(boton circular dentro de la fila - )
            .toolbar {
                EditButton()
            }
        }
    }
    // Utilizo la funcion removeRows para eliminar filas de la lista y lo aplico en el perform de .onDelete()
    func removeRows(at offsets: IndexSet) { // IndexSet es una colección de numeros enteros.
        numbers.remove(atOffsets: offsets) // llamo al metodo atOffsets para poder eliminaar las posiciones de la lista
        
}
}

#Preview {
    onDeleteView()
}
