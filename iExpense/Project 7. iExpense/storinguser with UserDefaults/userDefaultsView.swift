//
//  userDefaultsView.swift
//  Project 7. iExpense
//
//  Created by Fernando Jurado on 18/9/24.
//

import SwiftUI

struct userDefaultsView: View {
    // si quisiera almacenar estos valores del tapCount sin necesidad de guardarlo en la forKey llamada "Tap" con UserDefaults podría utilizar la propiedad @AppStorage en vez de @State y asignarle su clave a continuación, en este caso llamada tapCount
    @AppStorage("tapCount") private var tapCount = 0
    //@State private var tapCount = 0
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            // utilizo userDefaults para almacenar el valor de tapCount de forma persistente en el dispositivo. En este caso el valor se podrá recuperar mas adelante incluso saliendo, cerrando y abriendo la app del dispositivo
            //UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

#Preview {
    userDefaultsView()
}
